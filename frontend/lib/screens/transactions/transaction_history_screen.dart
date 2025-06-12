import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart'; // Optional: For sharing files
import '../../widgets/table_column.dart';

import '../../models/transaction_record.dart';
import '../../services/transaction_service.dart';
import '../../widgets/generic_data_table.dart';

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  final _searchCtrl = TextEditingController();
  final currencyFormat = NumberFormat('#,##0.00', 'en_IN');
  final dateFormat = DateFormat('yyyy-MM-dd HH:mm');

  List<TransactionRecord> _all = [];
  List<TransactionRecord> _filtered = [];

  @override
  void initState() {
    super.initState();
    _loadRecords();
  }

  Future<void> _loadRecords() async {
    final data = await TransactionService.getAll();
    setState(() {
      _all = data;
      _filtered = data;
    });
  }

  void _filter(String q) {
    final lower = q.toLowerCase();
    setState(() {
      _filtered = _all.where((r) =>
        r.billId.toLowerCase().contains(lower) ||
        r.customerName.toLowerCase().contains(lower) ||
        r.productName.toLowerCase().contains(lower) ||
        r.paymentMode.toLowerCase().contains(lower) ||
        r.branch.toLowerCase().contains(lower)
      ).toList();
    });
  }

  Future<void> _exportCsv() async {
    final now = DateTime.now();
    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(now);
    final filename = 'transactions_export_$timestamp.csv';

    final buffer = StringBuffer();
    buffer.writeln([
      'Date','Bill ID','Line ID','Customer','Phone','GST No.',
      'Product','Category','Qty','Unit Price','GST Slab','GST %',
      'Tax Amount','Total','Payment Mode','Branch'
    ].join(','));

    for (var r in _filtered) {
      buffer.writeln([
        r.date.toIso8601String(),
        r.billId,
        r.lineId,
        r.customerName,
        r.customerPhone,
        r.customerGst,
        r.productName,
        r.category,
        r.quantity,
        r.unitPrice.toStringAsFixed(2),
        r.gstSlab,
        r.gstRate,
        r.taxAmount.toStringAsFixed(2),
        r.totalAmount.toStringAsFixed(2),
        r.paymentMode,
        r.branch
      ].join(','));
    }

    try {
      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/$filename';
      final file = File(path);
      await file.writeAsString(buffer.toString());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("CSV exported to:\n$path"))
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to export CSV"))
      );
    }
  }

  Future<void> _exportPdf() async {
    final pdf = pw.Document();
    final now = DateTime.now();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Transaction Report', style: pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 10),
              pw.Text('Generated on ${dateFormat.format(now)}'),
              pw.SizedBox(height: 20),
              pw.Table.fromTextArray(
                headers: ['Date', 'Customer', 'Product', 'Qty', 'Total', 'Payment'],
                data: _filtered.map((r) => [
                  dateFormat.format(r.date),
                  r.customerName,
                  r.productName,
                  r.quantity.toString(),
                  '₹${currencyFormat.format(r.totalAmount)}',
                  r.paymentMode
                ]).toList(),
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                cellAlignment: pw.Alignment.centerLeft,
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final columns = [
      TableColumn<Map<String, String>>(title: 'Date', field: 'date'),
      TableColumn<Map<String, String>>(title: 'Bill ID', field: 'bill_id'),
      TableColumn<Map<String, String>>(title: 'Line ID', field: 'line_id'),
      TableColumn<Map<String, String>>(title: 'Customer', field: 'customer_name'),
      TableColumn<Map<String, String>>(title: 'Phone', field: 'customer_phone'),
      TableColumn<Map<String, String>>(title: 'GST No.', field: 'customer_gst'),
      TableColumn<Map<String, String>>(title: 'Product', field: 'product_name'),
      TableColumn<Map<String, String>>(title: 'Category', field: 'category'),
      TableColumn<Map<String, String>>(title: 'Qty', field: 'quantity'),
      TableColumn<Map<String, String>>(title: 'Unit Price', field: 'unit_price'),
      TableColumn<Map<String, String>>(title: 'GST Slab', field: 'gst_slab'),
      TableColumn<Map<String, String>>(title: 'GST %', field: 'gst_rate'),
      TableColumn<Map<String, String>>(title: 'Tax Amt', field: 'tax_amount'),
      TableColumn<Map<String, String>>(title: 'Total', field: 'total_amount'),
      TableColumn<Map<String, String>>(title: 'Payment', field: 'payment_mode'),
      TableColumn<Map<String, String>>(title: 'Branch', field: 'branch'),
    ];

    final rows = _filtered.map((r) => {
      'date': r.date.toIso8601String(),
      'bill_id': r.billId,
      'line_id': r.lineId,
      'customer_name': r.customerName,
      'customer_phone': r.customerPhone,
      'customer_gst': r.customerGst,
      'product_name': r.productName,
      'category': r.category,
      'quantity': r.quantity.toString(),
      'unit_price': '₹${currencyFormat.format(r.unitPrice)}',
      'gst_slab': r.gstSlab,
      'gst_rate': r.gstRate.toString(),
      'tax_amount': '₹${currencyFormat.format(r.taxAmount)}',
      'total_amount': '₹${currencyFormat.format(r.totalAmount)}',
      'payment_mode': r.paymentMode,
      'branch': r.branch,
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History'),
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              child: GenericDataTable<Map<String, String>>(
                columns: columns,
                rows: rows,
                onExportCsv: _exportCsv,
                onExportPdf: _exportPdf,
                onSearch: _filter,
                searchHint: 'Search by customer, product, etc.',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
