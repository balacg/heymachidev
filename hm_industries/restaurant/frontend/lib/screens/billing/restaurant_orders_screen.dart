// restaurant/frontend/lib/screens/billing/restaurant_orders_screen.dart

import 'package:flutter/material.dart';
import 'package:restaurant_addon/constants/dining_types.dart';
import 'package:restaurant_addon/screens/billing/restaurant_cart_page.dart';
import 'package:heymachi_dev/utils/app_session.dart';
import 'package:heymachi_dev/models/cart_item.dart';
import '../../services/restaurant_api.dart';

class RestaurantOrdersScreen extends StatefulWidget {
  const RestaurantOrdersScreen({Key? key}) : super(key: key);

  @override
  State<RestaurantOrdersScreen> createState() => _RestaurantOrdersScreenState();
}

class _RestaurantOrdersScreenState extends State<RestaurantOrdersScreen> {
  List<dynamic> openOrders = [];
  List<String> occupiedTables = [];

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    try {
      final orders = await RestaurantApi.getOpenOrders();
      setState(() {
        openOrders = orders;
        occupiedTables = orders
            .where((o) => o['dining_mode'] == DiningTypes.dineIn)
            .map<String>((o) => o['table_no']?.toString() ?? '')
            .toList();
      });
    } catch (e) {
      debugPrint('Error loading orders: $e');
    }
  }

  Map<String, Map<String, dynamic>> _convertToCartItems(List<dynamic> items) {
    final result = <String, Map<String, dynamic>>{};
    for (var it in items) {
      final id = (it['product_id'] as String?) ?? (it['item'] as String?);
      final qty = (it['quantity'] as int?) ?? (it['qty'] as int?);
      final price = (it['price'] as num?)?.toDouble();
      if (id != null && qty != null && price != null) {
        result[id] = {'qty': qty, 'price': price};
      }
    }
    return result;
  }

  Future<void> _onTapTable(String tableNo) async {
    final isOccupied = occupiedTables.contains(tableNo);

    // seed session
    AppSession.instance.sessionData
      ..clear()
      ..['dining_mode'] = DiningTypes.dineIn
      ..['table_no']    = tableNo
      ..['pax']         = 1
      ..['token_no']    = await RestaurantApi.getTokenForType('DL');

    // always push into RestaurantCartPage
    final cartMap = isOccupied
        ? _convertToCartItems(
            openOrders.firstWhere((o) => o['table_no'] == tableNo)['items']
              as List<dynamic>)
        : <String, Map<String, dynamic>>{};

    final existingOrder = isOccupied
        ? openOrders.firstWhere((o) => o['table_no'] == tableNo)
        : null;

    final saved = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => RestaurantCartPage(
          cartItems: cartMap,
          initialOrder: existingOrder,
          fromOpenOrder: isOccupied,
        ),
      ),
    );
    debugPrint('🏷️ _onTapTable returned: $saved');
    if (saved == true) {
      await _loadOrders();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Orders')),
      body: GridView.count(
        crossAxisCount: 4,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: List.generate(12, (i) {
          final tableNo = 'T${i + 1}';
          final isOccupied = occupiedTables.contains(tableNo);
          return GestureDetector(
            onTap: () => _onTapTable(tableNo),
            child: Container(
              decoration: BoxDecoration(
                color: isOccupied ? Colors.blue[200] : Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black12),
              ),
              child: Center(
                child: Text(tableNo,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          );
        }),
      ),
    );
  }
}
