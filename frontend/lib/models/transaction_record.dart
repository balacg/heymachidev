// lib/models/transaction_record.dart

class TransactionRecord {
  final String billId;
  final String lineId; // unique per line
  final DateTime date;
  final String customerName;
  final String customerPhone;
  final String customerGst;
  final String productName;
  final String category;
  final int quantity;
  final double unitPrice;
  final String gstSlab;
  final double gstRate;
  final double taxAmount;
  final double totalAmount;
  final String paymentMode;
  final String branch;

  TransactionRecord({
    required this.billId,
    required this.lineId,
    required this.date,
    required this.customerName,
    required this.customerPhone,
    required this.customerGst,
    required this.productName,
    required this.category,
    required this.quantity,
    required this.unitPrice,
    required this.gstSlab,
    required this.gstRate,
    required this.taxAmount,
    required this.totalAmount,
    required this.paymentMode,
    required this.branch,
  });
}
