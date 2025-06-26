// restaurant/frontend/lib/screens/billing/edit_open_order_screen.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_addon/screens/billing/restaurant_item_catalog_page.dart';
import '../../services/restaurant_api.dart';
import 'package:heymachi_dev/widgets/widget_utils.dart';

class EditOpenOrderScreen extends StatefulWidget {
  final Map<String, dynamic> order;

  const EditOpenOrderScreen({super.key, required this.order});

  @override
  State<EditOpenOrderScreen> createState() => _EditOpenOrderScreenState();
}

class _EditOpenOrderScreenState extends State<EditOpenOrderScreen> {
  late Map<String, dynamic> order;
  late List<Map<String, dynamic>> items;

  @override
  void initState() {
    super.initState();
    order = Map<String, dynamic>.from(widget.order);
    final rawItems = order['items'];
    items = rawItems is List
        ? rawItems
            .map<Map<String, dynamic>>(
              (e) => {
                'name': e['name']?.toString() ?? '',
                'price': (e['price'] is num) ? e['price'].toDouble() : 0.0,
                'qty': (e['qty'] is int) ? e['qty'] : 1,
              },
            )
            .toList()
        : [];
  }

  void updateQuantity(int index, int delta) {
    setState(() {
      items[index]['qty'] += delta;
      if (items[index]['qty'] <= 0) items.removeAt(index);
    });
  }

  double get totalAmount => items.fold(
        0,
        (sum, item) => sum + (item['qty'] * item['price']),
      );

  Future<void> saveOrder() async {
    final updated = {
      ...order,
      'items': items,
      'total_amount': totalAmount,
    };

    await RestaurantApi.createOrUpdateOrder(updated);
    Navigator.pop(context, true);
  }

  Future<void> handleAddItem() async {
    final selected = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const RestaurantItemCatalogPage(),
      ),
    );

    if (selected != null && selected['name'] != null) {
      setState(() {
        final existing = items.firstWhere(
          (e) => e['name'] == selected['name'],
          orElse: () => {},
        );
        if (existing.isNotEmpty) {
          existing['qty'] += 1;
        } else {
          items.add({
            'name': selected['name'],
            'qty': 1,
            'price': (selected['price'] is num)
                ? selected['price'].toDouble()
                : 0.0,
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,##0.00', 'en_IN');

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Order')),
      body: SafeArea(
        child: Column(
          children: [
            if (order['table_no'] != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Table ${order['table_no']} (${order['pax'] ?? '-'} pax)',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text("Add Item"),
                onPressed: handleAddItem,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (_, i) => ListTile(
                  title: Text(items[i]['name']),
                  subtitle:
                      Text("₹${formatter.format(items[i]['price'] ?? 0.0)}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => updateQuantity(i, -1)),
                      Text('${items[i]['qty']}'),
                      IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => updateQuantity(i, 1)),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text("Save Order"),
                onPressed: saveOrder,
              ),
            )
          ],
        ),
      ),
    );
  }
}
