// restaurant/frontend/lib/screens/billing/restaurant_item_catalog_page.dart

import 'package:flutter/material.dart';
import 'package:heymachi_dev/models/cart_item.dart';
import 'package:heymachi_dev/screens/billing/item_catalog_page.dart'
    as core_catalog;
import 'package:heymachi_dev/utils/app_session.dart';
import 'package:heymachi_dev/screens/billing/cart_page.dart';

class RestaurantItemCatalogPage extends StatelessWidget {
  final List<CartItem>? initialCartItems;
  final String? openOrderId;

  const RestaurantItemCatalogPage({
    super.key,
    this.initialCartItems,
    this.openOrderId,
  });

  @override
  Widget build(BuildContext context) {
    final session = AppSession.instance.sessionData;
    final diningType = session['dining_mode'] ?? '-';
    final tableNo = session['table_no'] ?? '-';
    final pax = session['pax'] ?? '-';
    final token = session['token_no'] ?? '-';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Catalog'),
        leading: const BackButton(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Session Info Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Text(
              diningType == 'Dine-In'
                  ? 'Table: $tableNo  •  Pax: $pax'
                  : 'Token: ${token.isNotEmpty ? token : '—'}',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
          const Divider(height: 1),
          // Core Catalog + Patch
          Expanded(
            child: core_catalog.ItemCatalogPage(
              isSelectorMode: openOrderId != null,  // ✅ Only go into selector mode when editing an existing order
              initialCartItems: initialCartItems,
              onCartConfirmed: openOrderId != null
                  ? (List<CartItem> updatedCart) {
                      Navigator.pop(context, {
                        'cartItems': updatedCart,
                        'id': openOrderId,
                      });
                    }
                  : null,  // ✅ Do not pop when just adding normally
            ),
          ),
        ],
      ),
    );
  }
}
