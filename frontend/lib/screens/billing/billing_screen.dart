// lib/screens/billing/billing_screen.dart

import 'package:flutter/material.dart';

class BillingScreen extends StatelessWidget {
  final Map<String, dynamic> cartItems;

  const BillingScreen({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    final totalAmount = cartItems.entries.fold(
      0.0,
      (sum, item) => sum + (item.value['qty'] * item.value['price']),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Final Billing'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Billing Summary',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...cartItems.entries.map((entry) {
              final name = entry.key;
              final qty = entry.value['qty'];
              final price = entry.value['price'];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  "$name x$qty = ₹${(qty * price).toStringAsFixed(0)}",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              );
            }).toList(),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Total: ₹${totalAmount.toStringAsFixed(0)}",
                style: const TextStyle(
                    color: Colors.amberAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
