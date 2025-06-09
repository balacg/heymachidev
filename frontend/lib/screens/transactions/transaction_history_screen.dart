// lib/screens/transactions/transaction_history_screen.dart

import 'package:flutter/material.dart';
import '../../models/transaction_record.dart';
import '../../services/transaction_service.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  List<TransactionRecord> _all = [], _filtered = [];
  final _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    _all = await TransactionService.getAll();
    _filtered = List.from(_all);
    setState(() {});
  }

  void _filter(String q) {
    final lower = q.toLowerCase();
    _filtered = _all.where((t) {
      return t.billId.toLowerCase().contains(lower) ||
          t.lineId.toLowerCase().contains(lower) ||
          t.customerName.toLowerCase().contains(lower) ||
          t.productName.toLowerCase().contains(lower) ||
          t.paymentMode.toLowerCase().contains(lower) ||
          t.branch.toLowerCase().contains(lower);
    }).toList();
    setState(() {});
  }

  String _fmt(DateTime dt) =>
      '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} '
      '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    const headerStyle = TextStyle(fontWeight: FontWeight.bold);

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
              decoration: const InputDecoration(
                labelText: 'Search by Bill, Customer, Product, …',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _filter,
            ),
            const SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor:
                      MaterialStateProperty.all(Colors.grey[200]),
                  columns: const [
                    DataColumn(label: Text('Bill ID', style: headerStyle)),
                    DataColumn(label: Text('Line ID', style: headerStyle)),
                    DataColumn(label: Text('Date', style: headerStyle)),
                    DataColumn(
                        label: Text('Customer', style: headerStyle)),
                    DataColumn(label: Text('Phone', style: headerStyle)),
                    DataColumn(label: Text('GST No.', style: headerStyle)),
                    DataColumn(label: Text('Product', style: headerStyle)),
                    DataColumn(label: Text('Category', style: headerStyle)),
                    DataColumn(label: Text('Qty', style: headerStyle)),
                    DataColumn(
                        label: Text('Unit Price', style: headerStyle)),
                    DataColumn(label: Text('GST Slab', style: headerStyle)),
                    DataColumn(
                        label: Text('Tax Amt', style: headerStyle)),
                    DataColumn(
                        label: Text('Line Total', style: headerStyle)),
                    DataColumn(
                        label: Text('Payment', style: headerStyle)),
                    DataColumn(label: Text('Branch', style: headerStyle)),
                  ],
                  rows: _filtered.map((t) {
                    return DataRow(cells: [
                      DataCell(Text(t.billId)),
                      DataCell(Text(t.lineId)),
                      DataCell(Text(_fmt(t.date))),
                      DataCell(Text(t.customerName)),
                      DataCell(Text(t.customerPhone)),
                      DataCell(Text(t.customerGst)),
                      DataCell(Text(t.productName)),
                      DataCell(Text(t.category)),
                      DataCell(Text(t.quantity.toString())),
                      DataCell(Text('₹${t.unitPrice.toStringAsFixed(2)}')),
                      DataCell(Text(t.gstSlab)),
                      DataCell(Text('₹${t.taxAmount.toStringAsFixed(2)}')),
                      DataCell(Text('₹${t.totalAmount.toStringAsFixed(2)}')),
                      DataCell(Text(t.paymentMode)),
                      DataCell(Text(t.branch)),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
