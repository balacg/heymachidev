// lib/screens/billing/order_confirmation_screen.dart

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import '../../models/customer.dart';
import '../../modules/restaurant/templates/pdf/thermal_bill_template.dart';
import '../../services/email_service.dart';
import '../../services/api.dart';
import '../../widgets/order_meta_display.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final Customer customer;
  final String paymentMode;
  final double totalAmount;
  final List<Map<String, dynamic>> items;
  final String orderId;
  final double cgst;
  final double sgst;
  final double igst;

  final String? promoTitle;
  final double? promoPercentage;
  final double? promoDiscount;

  final Map<String, dynamic> sessionData;
  final Map<String, String> sessionLabels;

  const OrderConfirmationScreen({
    Key? key,
    required this.customer,
    required this.paymentMode,
    required this.totalAmount,
    required this.items,
    required this.orderId,
    required this.cgst,
    required this.sgst,
    required this.igst,
    required this.sessionData,
    required this.sessionLabels,
    this.promoTitle,
    this.promoPercentage,
    this.promoDiscount,
  }) : super(key: key);

  Future<Uint8List> _generatePdfBytes() async {
    final business = await ApiService.fetchBusinessProfile();
    final pdfDoc = await buildThermalPDF(
      orderId: orderId,
      customer: customer.toJson(),
      items: items,
      totalAmount: totalAmount,
      paymentMode: paymentMode,
      business: business,
      promoTitle: promoTitle,
      promoDiscountPercentage: promoPercentage,
      promoDiscountValue: promoDiscount,
    );
    return await pdfDoc.save();
  }

  Future<void> _handleExport(BuildContext context) async {
    try {
      final business = await ApiService.fetchBusinessProfile();
      final pdfBytes = await _generatePdfBytes();

      if ((customer.email ?? '').isNotEmpty) {
        await EmailService.sendEmailWithPDF(
          toEmail: customer.email!,
          subject: 'Your Order Confirmation',
          body: 'Hi ${customer.name},\n\nHere’s your bill from ${business['name'] ?? 'HeyMachi'} 💖',
          pdfBytes: pdfBytes,
          filename: 'order_$orderId.pdf',
        );
      }

      await EmailService.sendEmailWithPDF(
        toEmail: 'owner@yourbiz.com',
        subject: 'New Order Placed - $orderId',
        body:
            'Customer: ${customer.name}\nAmount: ₹${totalAmount.toStringAsFixed(2)}\nOrder ID: $orderId',
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (r) => false),
        ),
        title: Row(
          children: const [
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 8),
            Text('Order Confirmed'),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              final pdfBytes = await _generatePdfBytes();
              if (value == 'pdf') {
                await Printing.layoutPdf(onLayout: (_) async => pdfBytes);
              } else if (value == 'save') {
                final file =
                    await EmailService.savePDFToFile(pdfBytes, 'order_$orderId.pdf');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Saved to: ${file.path}")),
                );
              } else if (value == 'email') {
                await _handleExport(context);
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(value: 'pdf', child: Text('Print PDF')),
              const PopupMenuItem(value: 'save', child: Text('Save as PDF')),
              const PopupMenuItem(value: 'email', child: Text('Email Invoice')),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: ListView(
          children: [
            OrderMetaDisplay(
              sessionData: sessionData.map((k, v) => MapEntry(k, v.toString())),
              sessionLabels: sessionLabels,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const Divider(),
            Text('Customer: ${customer.name}', style: theme.textTheme.titleMedium),
            Text('Phone: ${customer.phone}', style: theme.textTheme.bodyMedium),
            Text('Address: ${customer.address ?? ''}, ${customer.state ?? ''}',
                style: theme.textTheme.bodyMedium),
            if ((customer.email ?? '').isNotEmpty)
              Text('Email: ${customer.email}', style: theme.textTheme.bodyMedium),
            const SizedBox(height: 12),
            Text('Payment Mode: $paymentMode', style: theme.textTheme.bodyMedium),
            const Divider(),
            Text('Items Summary:',
                style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            ...items.map((item) {
              final name = item['productName']?.toString() ?? 'Unnamed Item';
              final qty = item['quantity'] ?? 0;
              final price = item['unitPrice'] ?? 0.0;
              final total = item['totalAmount'] ?? 0.0;
              return ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: Text(name, style: theme.textTheme.bodyLarge),
                subtitle: Text('Qty: $qty x ₹${formatter.format(price)}'),
                trailing: Text('₹${formatter.format(total)}',
                    style: theme.textTheme.bodyLarge),
              );
            }).toList(),
            const Divider(),
            if (igst > 0)
              _buildAlignedRow('Total IGST', igst, theme)
            else ...[
              _buildAlignedRow('Total CGST', cgst, theme),
              _buildAlignedRow('Total SGST', sgst, theme),
            ],
            const Divider(),
            if ((promoTitle ?? '').isNotEmpty && (promoDiscount ?? 0) > 0)
              _buildAlignedRow('Promo "$promoTitle" Discount', -promoDiscount!, theme),
            _buildAlignedRow('Grand Total', totalAmount, theme, isBold: true),
          ],
        ),
      ),
    );
  }

  Widget _buildAlignedRow(String label, double value, ThemeData theme, {bool isBold = false}) {
    final textStyle = isBold
        ? theme.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold)
        : theme.textTheme.bodyMedium!;
    final formatter = NumberFormat('#,##0.00', 'en_IN');

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: textStyle),
          Text('₹${formatter.format(value)}', style: textStyle),
        ],
      ),
    );
  }
}
