// lib/modules/restaurant/templates/pdf/thermal_bill_template.dart

import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<pw.Document> buildThermalPDF({
  required String orderId,
  required Map<String, dynamic> customer,
  required List<Map<String, dynamic>> items,
  required double totalAmount,
  required String paymentMode,
  required Map<String, dynamic> business,
  Map<String, dynamic>? sessionData,
  Map<String, String>? sessionLabels,
  String? promoTitle,
  double? promoDiscountPercentage,
  double? promoDiscountValue,
}) async {
  final pdf = pw.Document();
  final notoFont = pw.Font.ttf(await rootBundle.load('assets/fonts/NotoSans-Regular.ttf'));

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.roll80,
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Center(
              child: pw.Text(
                business['name'] ?? 'Your Business',
                style: pw.TextStyle(font: notoFont, fontSize: 16, fontWeight: pw.FontWeight.bold),
              ),
            ),
            if ((business['gst_number'] ?? '').isNotEmpty)
              pw.Center(
                child: pw.Text("GST: ${business['gst_number']}", style: pw.TextStyle(font: notoFont)),
              ),
            pw.Divider(),

            pw.Text("Order ID: $orderId", style: pw.TextStyle(font: notoFont, fontSize: 10)),
            pw.Text("Payment Mode: $paymentMode", style: pw.TextStyle(font: notoFont, fontSize: 10)),

            if (sessionLabels != null && sessionData != null) ...[
              pw.SizedBox(height: 6),
              ...sessionLabels.entries.map((e) {
                final val = sessionData[e.key];
                return val != null
                    ? pw.Text("${e.value}: $val", style: pw.TextStyle(font: notoFont, fontSize: 10))
                    : pw.SizedBox();
              }),
            ],

            pw.SizedBox(height: 10),

            pw.Text("Items:", style: pw.TextStyle(font: notoFont, decoration: pw.TextDecoration.underline)),
            ...items.map((item) => pw.Text(
              "${item['productName'] ?? 'Item'} x${item['quantity'] ?? 0}  ₹${(item['unitPrice'] ?? 0).toStringAsFixed(2)}",
              style: pw.TextStyle(font: notoFont, fontSize: 10),
            )),

            pw.Divider(),

            if (promoTitle != null && promoDiscountPercentage != null && promoDiscountValue != null) ...[
              pw.Text("Promo Applied: $promoTitle", style: pw.TextStyle(font: notoFont, fontSize: 10)),
              pw.Text("Discount (${promoDiscountPercentage.toStringAsFixed(0)}%): - ₹${promoDiscountValue.toStringAsFixed(2)}",
                  style: pw.TextStyle(font: notoFont, fontSize: 10)),
            ],

            pw.Text("Total Amount: ₹${totalAmount.toStringAsFixed(2)}",
                style: pw.TextStyle(font: notoFont, fontSize: 12, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),

            pw.Center(
              child: pw.Text(
                business['footer_note'] ?? 'Thanks for your visit 💖',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(font: notoFont, fontSize: 10),
              ),
            ),
          ],
        );
      },
    ),
  );

  return pdf;
}
