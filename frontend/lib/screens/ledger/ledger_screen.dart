import 'package:flutter/material.dart';

class LedgerScreen extends StatelessWidget {
  const LedgerScreen({super.key});

  final List<Map<String, dynamic>> ledgerEntries = const [
    {
      'title': 'Payment received from Customer A',
      'date': '2025-06-05',
      'amount': 2500.00,
      'balance': 15000.00,
      'isCredit': true,
    },
    {
      'title': 'Purchase from Vendor X',
      'date': '2025-06-04',
      'amount': 1200.00,
      'balance': 12500.00,
      'isCredit': false,
    },
    {
      'title': 'Salary paid',
      'date': '2025-06-03',
      'amount': 3000.00,
      'balance': 13700.00,
      'isCredit': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ledger')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSummaryCard('Total Credits', 2500.00, Colors.green),
                _buildSummaryCard('Total Debits', 4200.00, Colors.red),
                Flexible(
                  child: _buildSummaryCard('Balance', -1700.00, Colors.blue),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: ledgerEntries.length,
              itemBuilder: (context, index) {
                final entry = ledgerEntries[index];
                return ListTile(
                  leading: Icon(
                    entry['isCredit'] ? Icons.arrow_downward : Icons.arrow_upward,
                    color: entry['isCredit'] ? Colors.green : Colors.red,
                  ),
                  title: Text(entry['title']),
                  subtitle: Text(
                      '${entry['date']}\nBal: ₹${entry['balance'].toStringAsFixed(2)}'),
                  trailing: Text(
                    '₹${entry['amount'].toStringAsFixed(2)}',
                    style: TextStyle(
                      color: entry['isCredit'] ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  isThreeLine: true,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, double amount, Color color) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(minWidth: 100),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('₹${amount.toStringAsFixed(2)}',
                style: TextStyle(fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }
}
