// lib/screens/master/tax_master_screen.dart

import 'package:flutter/material.dart';

class TaxMasterScreen extends StatefulWidget {
  const TaxMasterScreen({super.key});

  @override
  State<TaxMasterScreen> createState() => _TaxMasterScreenState();
}

class _TaxMasterScreenState extends State<TaxMasterScreen> {
  final TextEditingController taxNameController = TextEditingController();
  final TextEditingController taxRateController = TextEditingController();

  final List<Map<String, dynamic>> taxList = [
    {'id': 1, 'name': 'GST', 'rate': '18%'},
    {'id': 2, 'name': 'VAT', 'rate': '5%'},
  ];

  @override
  void dispose() {
    taxNameController.dispose();
    taxRateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tax Master'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: taxList.length,
                itemBuilder: (context, index) {
                  final tax = taxList[index];
                  return ListTile(
                    leading: Text('${index + 1}'),
                    title: Text(tax['name']),
                    subtitle: Text('Rate: ${tax['rate']}'),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) => [
                        const PopupMenuItem(value: 'edit', child: Text('Edit')),
                        const PopupMenuItem(value: 'delete', child: Text('Delete')),
                      ],
                      onSelected: (value) {
                        // Handle edit/delete
                      },
                    ),
                  );
                },
              ),
            ),
            TextField(
              controller: taxNameController,
              decoration: const InputDecoration(labelText: 'Tax Name'),
            ),
            TextField(
              controller: taxRateController,
              decoration: const InputDecoration(labelText: 'Tax Rate (%)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save logic here
              },
              child: const Text('Add Tax'),
            )
          ],
        ),
      ),
    );
  }
}
