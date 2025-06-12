// lib/screens/billing/order_confirmation_screen.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/customer.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final Customer customer;
  final String paymentMode;
  final double totalAmount;

  const OrderConfirmationScreen({
    Key? key,
    required this.customer,
    required this.paymentMode,
    required this.totalAmount,
  }) : super(key: key);

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
            const Spacer(),

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
