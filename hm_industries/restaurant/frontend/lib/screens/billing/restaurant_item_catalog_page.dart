// restaurant/frontend/lib/screens/billing/restaurant_item_catalog_page.dart

import 'package:flutter/material.dart';
import 'package:heymachi_dev/models/cart_item.dart';
import 'package:heymachi_dev/screens/billing/item_catalog_page.dart' as core;
import 'package:heymachi_dev/utils/app_session.dart';
import 'package:restaurant_addon/constants/dining_types.dart';

class RestaurantItemCatalogPage extends StatefulWidget {
  final List<CartItem> initialCartItems;
  final String? openOrderId;

  const RestaurantItemCatalogPage({
    Key? key,
    this.initialCartItems = const [],
    this.openOrderId,
  }) : super(key: key);

  @override
  _RestaurantItemCatalogPageState createState() =>
      _RestaurantItemCatalogPageState();
}

class _RestaurantItemCatalogPageState
    extends State<RestaurantItemCatalogPage> {
  late List<CartItem> _cart;

  @override
  void initState() {
    super.initState();
    _cart = List.from(widget.initialCartItems);
  }

  void _onCartConfirmed(List<CartItem> updated) {
    setState(() => _cart = updated);
  }

  @override
  Widget build(BuildContext context) {
    final session = AppSession.instance.sessionData;
    final mode  = session['dining_mode'] ?? '-';
    final table = session['table_no']   ?? '-';
    final pax   = session['pax']?.toString() ?? '-';
    final token = session['token_no']   ?? '-';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Catalog'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, null),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, {
                'cartItems': _cart,
                'id': widget.openOrderId,
              });
            },
            child: const Text('Done', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              mode == DiningTypes.dineIn
                  ? 'Table: $table • Pax: $pax'
                  : 'Token: ${token.isNotEmpty ? token : '—'}',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: core.ItemCatalogPage(
              isSelectorMode: false,
              initialCartItems: _cart,
              onCartConfirmed: _onCartConfirmed,
            ),
          ),
        ],
      ),
    );
  }
}
