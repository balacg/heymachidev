// restaurant/frontend/lib/screens/billing/orders_screen.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_addon/widgets/expandable_fab.dart';
import '../../services/restaurant_api.dart';
import 'package:heymachi_dev/screens/billing/cart_page.dart';
import 'package:heymachi_dev/screens/billing/item_catalog_page.dart';
import 'package:heymachi_dev/utils/app_session.dart';
import 'table_selector.dart';
import 'package:restaurant_addon/services/restaurant_api.dart';


class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<dynamic> openOrders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchOpenOrders();
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

  Map<String, Map<String, dynamic>> convertToCartItems(List<dynamic> items) {
    final Map<String, Map<String, dynamic>> result = {};
    for (var item in items) {
      if (item['name'] != null) {
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
    } else {
      // 👇 Dynamically generate token prefix from config
      final prefix = (mode == 'Takeaway') ? 'TK' : 'DL';
      try {
        final token = await RestaurantApi.getTokenForType(prefix);
        AppSession.instance.sessionData['token_no'] = token;
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to generate $prefix token')),
        );
        return;
      }
    }

    // ✅ Navigate to Item Catalog page
    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const ItemCatalogPage(),
        ),
      );
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
                    builder: (_) => CartPage(
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
      appBar: AppBar(title: const Text('Orders')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : openOrders.isEmpty
              ? const Center(child: Text('No open orders'))
              : RefreshIndicator(
                  onRefresh: fetchOpenOrders,
                  child: ListView.builder(
                    itemCount: openOrders.length,
                    itemBuilder: (context, index) {
                      return buildOrderCard(openOrders[index]);
                    },
                  ),
                ),
      floatingActionButton: buildFloatingFAB(),
    );
  }

  Widget buildFloatingFAB() {
    return ExpandableFab(
      distance: 112.0,
      children: [
        FloatingActionButton.extended(
          heroTag: 'dinein',
          onPressed: () => startNewOrder('Dine-In'),
          icon: const Icon(Icons.restaurant),
          label: const Text('Dine-In'),
        ),
        FloatingActionButton.extended(
          heroTag: 'takeaway',
          onPressed: () => startNewOrder('Takeaway'),
          icon: const Icon(Icons.shopping_bag),
          label: const Text('Takeaway'),
        ),
        FloatingActionButton.extended(
          heroTag: 'delivery',
          onPressed: () => startNewOrder('Delivery'),
          icon: const Icon(Icons.delivery_dining),
          label: const Text('Delivery'),
        ),
      ],
    );
  }
}

// Note: Implement ExpandableFab as a custom widget or use an available package to get FAB expansion animation.
