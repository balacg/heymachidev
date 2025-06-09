// lib/screens/billing/order_history_screen.dart

import 'package:flutter/material.dart';

class OrderHistoryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> dummyOrders = [
    {
      'date': '2025-06-04',
      'items': 3,
      'total': 580.0,
    },
    {
      'date': '2025-06-03',
      'items': 2,
      'total': 320.0,
    },
    {
      'date': '2025-06-02',
      'items': 4,
      'total': 750.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Order History")),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: ListView.separated(
          itemCount: dummyOrders.length,
          separatorBuilder: (_, __) => Divider(),
          itemBuilder: (_, index) {
            final order = dummyOrders[index];
            return ListTile(
              title: Text('Order on ${order['date']}'),
              subtitle: Text('${order['items']} items'),
              trailing: Text('₹ ${order['total'].toStringAsFixed(2)}'),
              onTap: () {
                // Future: Navigate to full order detail view
              },
            );
          },
        ),
      ),
    );
  }
}
