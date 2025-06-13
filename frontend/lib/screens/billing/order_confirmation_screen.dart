// lib/screens/billing/order_confirmation_screen.dart

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import '../../models/customer.dart';
import '../../modules/restaurant/templates/pdf/thermal_bill_template.dart';
import '../../services/email_service.dart';
import '../../services/api.dart'; // ✅ Fix: Import ApiService

class OrderConfirmationScreen extends StatelessWidget {
  final Customer customer;
  final String paymentMode;
  final double totalAmount;
  final List<Map<String, dynamic>> items;
  final String orderId;

  const OrderConfirmationScreen({
    Key? key,
    required this.customer,
    required this.paymentMode,
    required this.totalAmount,
    required this.items,
    required this.orderId,
  }) : super(key: key);

  Future<Uint8List> _generatePdfBytes() async {
    final business = await ApiService.fetchBusinessProfile(); // ✅ Add business

    final pdfDoc = buildThermalPDF(
      orderId: orderId,
      customer: customer.toJson(),
      items: items,
      totalAmount: totalAmount,
      paymentMode: paymentMode,
      business: business, // ✅ Fix missing param
    );
    return pdfDoc.save();
  }

  Future<void> _handleExport(BuildContext context) async {
    try {
      final business = await ApiService.fetchBusinessProfile();

      final pdfDoc = buildThermalPDF(
        orderId: orderId,
        customer: customer.toJson(),
        items: items,
        totalAmount: totalAmount,
        paymentMode: paymentMode,
        business: business,
      );

      final pdfBytes = await pdfDoc.save();

      // Email to customer
      if ((customer.email ?? '').isNotEmpty) {
        await EmailService.sendEmailWithPDF(
          toEmail: customer.email!,
          subject: 'Your Order Confirmation',
          body: 'Hi ${customer.name},\n\nHere’s your bill from ${business['name'] ?? 'HeyMachi'} 💖',
          pdfBytes: pdfBytes,
          filename: 'order_$orderId.pdf',
        );
      }

      // Email to business
      await EmailService.sendEmailWithPDF(
        toEmail: 'owner@yourbiz.com',
        subject: 'New Order Placed - $orderId',
        body: 'Customer: ${customer.name}\nAmount: ₹${totalAmount.toStringAsFixed(2)}\nOrder ID: $orderId',
        pdfBytes: pdfBytes,
        filename: 'order_$orderId.pdf',
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Emails sent (if addresses are valid)")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Export failed: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formatter = NumberFormat('#,##0.00', 'en_IN');

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Order Confirmed'),
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.iconTheme.color,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context, '/dashboard', (r) => false),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            tooltip: 'Export PDF / Email',
            onPressed: () => _handleExport(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 80, color: Colors.green),
            const SizedBox(height: 16),
            Text(
              'Order Confirmed!',
              style: theme.textTheme.headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Divider(color: theme.dividerColor),
            const SizedBox(height: 8),

            // Customer Info
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Customer Details',
                      style: theme.textTheme.titleMedium!
                          .copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('Name: ${customer.name}',
                      style: theme.textTheme.bodyMedium),
                  Text('Phone: ${customer.phone}',
                      style: theme.textTheme.bodyMedium),
                  if ((customer.email ?? '').isNotEmpty)
                    Text('Email: ${customer.email}',
                        style: theme.textTheme.bodyMedium),
                  if ((customer.gst ?? '').isNotEmpty)
                    Text('GST: ${customer.gst}',
                        style: theme.textTheme.bodyMedium),
                  if ((customer.address ?? '').isNotEmpty)
                    Text('Address: ${customer.address}',
                        style: theme.textTheme.bodyMedium),
                ],
              ),
            ),

            const SizedBox(height: 20),
            Divider(color: theme.dividerColor),

            // Payment & Summary
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order Summary',
                      style: theme.textTheme.titleMedium!
                          .copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Payment Mode: $paymentMode',
                      style: theme.textTheme.bodyMedium),
                  const SizedBox(height: 4),
                  Text('Total Amount: ₹${formatter.format(totalAmount)}',
                      style: theme.textTheme.titleMedium!
                          .copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            const SizedBox(height: 20),
            Divider(color: theme.dividerColor),

            // Print / Save / Email Again Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton.icon(
                  icon: const Icon(Icons.print),
                  label: const Text("Print"),
                  onPressed: () async {
                    final pdfBytes = await _generatePdfBytes();
                    await Printing.layoutPdf(onLayout: (format) async => pdfBytes);
                  },
                ),
                OutlinedButton.icon(
                  icon: const Icon(Icons.download),
                  label: const Text("Save"),
                  onPressed: () async {
                    final pdfBytes = await _generatePdfBytes();
                    final file = await EmailService.savePDFToFile(pdfBytes, 'order_$orderId.pdf');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Saved to: ${file.path}")),
                    );
                  },
                ),
                OutlinedButton.icon(
                  icon: const Icon(Icons.send),
                  label: const Text("Email"),
                  onPressed: () async {
                    await _handleExport(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Done Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.done),
                label: const Text('Back to Home'),
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context, '/dashboard', (r) => false),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
