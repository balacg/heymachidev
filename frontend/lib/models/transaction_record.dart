class TransactionRecord {
  final String billId;
  final String lineId;
  final DateTime date;
  final String customerName;
  final String customerPhone;
  final String customerGst;
  final String address;
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
    required this.address,
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

  factory TransactionRecord.fromJson(Map<String, dynamic> json) {
    return TransactionRecord(
      billId: json['bill_id'],
      lineId: json['line_id'],
      date: DateTime.parse(json['date']),
      customerName: json['customer_name'],
      customerPhone: json['customer_phone'],
      customerGst: json['customer_gst'],
      address: json['address'],
      productName: json['product_name'],
      category: json['category'],
      quantity: json['quantity'],
      unitPrice: (json['unit_price'] as num).toDouble(),
      gstSlab: json['gst_slab'],
      gstRate: (json['gst_rate'] as num).toDouble(),
      taxAmount: (json['tax_amount'] as num).toDouble(),
      totalAmount: (json['total_amount'] as num).toDouble(),
      paymentMode: json['payment_mode'],
      branch: json['branch'],
    );
  }

  Map<String, dynamic> toJson() => {
    "bill_id": billId,
    "line_id": lineId,
    "date": date.toIso8601String(),
    "customer_name": customerName,
    "customer_phone": customerPhone,
    "customer_gst": customerGst,
    "address": address,
    "product_name": productName,
    "category": category,
    "quantity": quantity,
    "unit_price": unitPrice,
    "gst_slab": gstSlab,
    "gst_rate": gstRate,
    "tax_amount": taxAmount,
    "total_amount": totalAmount,
    "payment_mode": paymentMode,
    "branch": branch
  };
}
