// restaurant/frontend/lib/screens/billing/table_selector.dart

import 'package:flutter/material.dart';
import 'package:heymachi_dev/utils/app_session.dart';
import 'package:restaurant_addon/screens/billing/restaurant_item_catalog_page.dart';
import 'package:restaurant_addon/services/restaurant_api.dart';

class TableSelectorPage extends StatefulWidget {
  const TableSelectorPage({super.key});

  @override
  State<TableSelectorPage> createState() => _TableSelectorPageState();
}

class _TableSelectorPageState extends State<TableSelectorPage> {
  String? selectedTable;
  int pax = 1;

  final List<String> tables = [
    'T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9', 'T10', 'T11', 'T12'
  ];

  void _proceed() async {
    if (selectedTable == null || pax < 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a table and pax')),
      );
      return;
    }

    try {
      final token = await RestaurantApi.getTokenForType('DL');
      //print('✅ Received Token: $token');
      AppSession.instance.sessionData.addAll({
        'dining_mode': 'Dine-In',
        'table_no': selectedTable,
        'pax': pax,
        'token_no': token,
      });
      //print('✅ Updated Session: ${AppSession.instance.sessionData}');

      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const RestaurantItemCatalogPage()),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to generate token')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Dining Mode'),
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.iconTheme.color,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select Table:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true,
              itemCount: tables.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2,
              ),
              itemBuilder: (_, i) {
                final table = tables[i];
                final isSelected = selectedTable == table;
                return GestureDetector(
                  onTap: () => setState(() => selectedTable = table),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: isSelected ? Colors.deepOrange : Colors.grey[300],
                    ),
                    child: Center(
                      child: Text(
                        table,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('No. of People: ', style: TextStyle(fontWeight: FontWeight.bold)),
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () => setState(() => pax = pax > 1 ? pax - 1 : 1),
                ),
                Text('$pax', style: const TextStyle(fontWeight: FontWeight.bold)),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () => setState(() => pax += 1),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _proceed,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(45),
                backgroundColor: Colors.deepOrange,
              ),
              child: const Text('Continue to Billing', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
