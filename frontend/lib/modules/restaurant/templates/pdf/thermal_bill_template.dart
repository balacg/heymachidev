// lib/modules/restaurant/templates/pdf/thermal_bill_template.dart

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Document buildThermalPDF({
  required String orderId,
  required Map<String, dynamic> customer,
  required List<Map<String, dynamic>> items,
  required double totalAmount,
  required String paymentMode,
  required Map<String, dynamic> business,
}) {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.roll80,
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Business Header
            pw.Center(
              child: pw.Text(
                business['name'] ?? 'Your Business',
                style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
              ),
            ),
            if ((business['gst_number'] ?? '').isNotEmpty)
              pw.Center(child: pw.Text("GST: ${business['gst_number']}")),

            pw.Divider(),

            pw.Text("Order ID: $orderId", style: const pw.TextStyle(fontSize: 10)),
            pw.Text("Payment Mode: $paymentMode", style: const pw.TextStyle(fontSize: 10)),

            pw.SizedBox(height: 10),
            pw.Text("Items:", style: pw.TextStyle(decoration: pw.TextDecoration.underline)),

            ...items.map((item) => pw.Text(
              "${item['name']} x${item['qty']}  ₹${item['price']}",
              style: const pw.TextStyle(fontSize: 10),
            )),

            pw.Divider(),

            pw.Text("Total Amount: ₹${totalAmount.toStringAsFixed(2)}",
                style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),

            pw.Center(
              child: pw.Text(
                business['footer_note'] ?? 'Thanks for your visit 💖',
                textAlign: pw.TextAlign.center,
                style: const pw.TextStyle(fontSize: 10),
              ),
            ),
          ],
        );
      },
    ),
  );

  return pdf;
}
