// lib/modules/restaurant/templates/csv/item_sales_export.dart

import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../models/transaction_record.dart';

Future<String> exportItemSalesCsv(List<TransactionRecord> records) async {
  final now = DateTime.now();
  final timestamp = DateFormat('yyyyMMdd_HHmmss').format(now);
  final filename = 'item_sales_export_$timestamp.csv';

  final buffer = StringBuffer();
  buffer.writeln([
    'Date','Bill ID','Customer','Product','Qty','Price','GST %','Tax','Total','Payment','Branch'
  ].join(','));

  for (var r in records) {
    buffer.writeln([
      DateFormat('yyyy-MM-dd HH:mm').format(r.date),
      r.billId,
      r.customerName,
      r.productName,
      r.quantity,
      r.unitPrice.toStringAsFixed(2),
      r.gstRate.toStringAsFixed(2),
      r.taxAmount.toStringAsFixed(2),
      r.totalAmount.toStringAsFixed(2),
      r.paymentMode,
      r.branch
    ].join(','));
  }

  final dir = await getApplicationDocumentsDirectory();
  final path = '${dir.path}/$filename';
  final file = File(path);
  await file.writeAsString(buffer.toString());
  return path;
}
