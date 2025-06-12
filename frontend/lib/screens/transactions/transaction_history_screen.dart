// lib/screens/transactions/transaction_history_screen.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart'; // Optional: For sharing files
import '../../widgets/table_column.dart';

import '../../models/transaction_record.dart';
import '../../services/transaction_service.dart';
import '../../widgets/generic_data_table.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  final formatter = NumberFormat('#,##0.00', 'en_IN');
  final _searchCtrl = TextEditingController();

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

  void _exportCsv() {
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

    // Output CSV (you can save or share)
    debugPrint(buffer.toString());
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("CSV Export logic complete (check console)"))
    );
  }

  void _exportPdf() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("PDF export coming soon..."))
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
      'unit_price': '₹${formatter.format(r.unitPrice)}',
      'gst_slab': r.gstSlab,
      'gst_rate': r.gstRate.toString(),
      'tax_amount': '₹${formatter.format(r.taxAmount)}',
      'total_amount': '₹${formatter.format(r.totalAmount)}',
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
            TextField(
              controller: _searchCtrl,
              onChanged: _filter,
              decoration: const InputDecoration(
                labelText: 'Search by customer, product, etc.',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: _exportCsv,
                  icon: const Icon(Icons.download),
                  label: const Text('Export CSV'),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: _exportPdf,
                  icon: const Icon(Icons.picture_as_pdf),
                  label: const Text('Export PDF'),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Expanded(
              child: GenericDataTable<Map<String, String>>(
                columns: columns,
                rows: rows,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
