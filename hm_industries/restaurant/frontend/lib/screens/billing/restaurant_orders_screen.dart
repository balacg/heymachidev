// restaurant/frontend/lib/screens/billing/orders_screen.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_addon/screens/billing/restaurant_cart_page.dart';
import 'package:restaurant_addon/widgets/expandable_fab.dart';
import '../../services/restaurant_api.dart';
import 'package:heymachi_dev/screens/billing/cart_page.dart';
import 'package:restaurant_addon/screens/billing/restaurant_item_catalog_page.dart';
import 'package:heymachi_dev/utils/app_session.dart';
import 'table_selector.dart';
import 'package:restaurant_addon/services/restaurant_api.dart';


class RestaurantOrdersScreen extends StatefulWidget {
  const RestaurantOrdersScreen({super.key});

  @override
  State<RestaurantOrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<RestaurantOrdersScreen> {
  List<dynamic> openOrders = [];
  bool isLoading = true;

  List<String> occupiedTables = [];

@override
void initState() {
  super.initState();
  loadOccupiedTables();
}

  Future<void> loadOccupiedTables() async {
    final orders = await fetchOrdersRaw();
    setState(() {
      occupiedTables = orders
          .where((o) => o['dining_mode'] == 'Dine-In')
          .map<String>((o) => o['table_no']?.toString() ?? '')
          .toList();
    });
  }



  Future<void> fetchOpenOrders() async {
    setState(() => isLoading = true);
    try {
      final data = await RestaurantApi.getOpenOrders();
      setState(() => openOrders = data);
    } catch (e) {
      debugPrint("Error fetching orders: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load orders')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<List<dynamic>> fetchOrdersRaw() async {
  try {
    return await RestaurantApi.getOpenOrders();
  } catch (e) {
    debugPrint("Error in fetchOrdersRaw: $e");
    return [];
  }
}

  Map<String, Map<String, dynamic>> convertToCartItems(List<dynamic> items) {
    final Map<String, Map<String, dynamic>> result = {};
    for (var item in items) {
      if (item['item'] != null) {
        result[item['name']] = {
          'qty': item['qty'],
          'price': item['price'],
        };
      }
    }
    return result;
  }

  void startNewOrder(String mode) async {
    AppSession.instance.sessionData.clear();
    AppSession.instance.sessionData['dining_mode'] = mode;

    if (mode == 'Dine-In') {
      final selected = await Navigator.pushNamed(context, '/table-selector');
      if (selected is Map<String, dynamic>) {
        AppSession.instance.sessionData.addAll(selected);
      } else {
        return; // Cancelled
      }

      final token = await RestaurantApi.getTokenForType('DL');
      AppSession.instance.sessionData['token_no'] = token;

      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const RestaurantItemCatalogPage(),
            settings: RouteSettings(arguments: {
              'cartItems': {},
              'id': null,
            }),
          ),
        );
      }

    } else {
      final prefix = (mode == 'Takeaway') ? 'TK' : 'DL';
      try {
        final token = await RestaurantApi.getTokenForType(prefix);
        AppSession.instance.sessionData['token_no'] = token;

        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const RestaurantItemCatalogPage(),
              settings: RouteSettings(arguments: {
                'cartItems': {},
                'id': null,
              }),
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to generate $prefix token')),
        );
      }
    }
  }


  Widget buildOrderCard(dynamic order) {
    final formatter = NumberFormat('#,##0.00', 'en_IN');
    final createdAt = DateTime.tryParse(order['created_at'] ?? '');
    final createdAtStr = createdAt != null
        ? DateFormat('dd MMM, hh:mm a').format(createdAt)
        : '-';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Row(
          children: [
            Chip(label: Text(order['dining_mode'] ?? '-')),
            const SizedBox(width: 10),
            Text(
              order['table_no'] != null
                  ? 'Table ${order['table_no']} (${order['pax']} pax)'
                  : 'Token ${order['token_no']}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (order['customer_name'] != null)
              Text("Customer: ${order['customer_name']}"),
            Text("Total: ₹${formatter.format(order['total_amount'])}"),
            Text("Started: $createdAtStr"),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () async {
                final cartMap = convertToCartItems(order['items']);
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RestaurantCartPage(
                      cartItems: cartMap,
                      onCartUpdated: (_) {},
                      fromOpenOrder: true,
                      initialOrder: order,
                    ),
                  ),
                );
                if (result == true) fetchOpenOrders();
              },
            ),
            IconButton(
              icon: const Icon(Icons.cancel, color: Colors.red),
              onPressed: () async {
                await RestaurantApi.cancelOrder(order['id']);
                fetchOpenOrders();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Table"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/open-orders');
            },
            child: const Text("View All Orders", style: TextStyle(color: Colors.white)),
          )
        ],
      ),
      body: GridView.count(
        crossAxisCount: 4,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: List.generate(12, (i) {
          final tableNo = 'T${i + 1}';
          final isOccupied = occupiedTables.contains(tableNo);

          return GestureDetector(
            onTap: () async {
              if (!isOccupied) {
                AppSession.instance.sessionData.clear();
                AppSession.instance.sessionData.addAll({
                  'dining_mode': 'Dine-In',
                  'table_no': tableNo,
                  'pax': 1,
                });

                final token = await RestaurantApi.getTokenForType('DL');
                AppSession.instance.sessionData['token_no'] = token;

                if (context.mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RestaurantItemCatalogPage(),
                    ),
                  );
                }
              }
 else {
                // 🧠 Load openOrders if not already loaded
                if (openOrders.isEmpty) {
                  openOrders = await fetchOrdersRaw();
                }

                // 🧲 Find the order for the tapped table
                final existingOrder = openOrders.firstWhere(
                  (o) => o['table_no'] == tableNo,
                  orElse: () => null,
                );

                if (existingOrder != null) {
                  final items = existingOrder['items'] as List<dynamic>? ?? [];
                  final Map<String, Map<String, dynamic>> cart = {
                    for (var item in items)
                      item['item']: {
                        'price': item['price'],
                        'qty': item['qty'],
                      }
                  };

                  AppSession.instance.sessionData.clear();
                  AppSession.instance.sessionData['dining_mode'] = 'Dine-In';
                  AppSession.instance.sessionData['table_no'] = tableNo;
                  AppSession.instance.sessionData['pax'] = existingOrder['pax'].toString();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RestaurantCartPage(
                        cartItems: cart,
                        onCartUpdated: (_) {},
                        fromOpenOrder: true,
                        initialOrder: existingOrder,
                      ),
                    ),
                  );
                }
              }
            },

            child: Container(
              decoration: BoxDecoration(
                color: isOccupied ? Colors.blue[200] : Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black12),
              ),
              child: Center(
                child: Text(
                  tableNo,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        }),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            heroTag: 'takeaway',
            label: const Text('Takeaway'),
            icon: const Icon(Icons.shopping_bag),
            onPressed: () async {
              try {
                AppSession.instance.sessionData.clear();
                AppSession.instance.sessionData['dining_mode'] = 'Takeaway';
                AppSession.instance.sessionData.remove('table_no');
                AppSession.instance.sessionData.remove('pax');

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RestaurantItemCatalogPage(),
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Failed to generate Takeaway token')),
                );
              }
            },

          ),
          const SizedBox(height: 12),
          FloatingActionButton.extended(
            heroTag: 'delivery',
            label: const Text('Delivery'),
            icon: const Icon(Icons.delivery_dining),
            onPressed: () async {
              try {
                AppSession.instance.sessionData.clear();
                AppSession.instance.sessionData['dining_mode'] = 'Delivery';
                AppSession.instance.sessionData.remove('table_no');
                AppSession.instance.sessionData.remove('pax');

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RestaurantItemCatalogPage(),
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Failed to generate Delivery token')),
                );
              }
            },

          ),
        ],
      ),
    );
  }

}
