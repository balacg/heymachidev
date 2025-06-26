// restaurant/frontend/lib/screens/billing/restaurant_cart_page.dart
import 'package:flutter/material.dart';
import 'package:heymachi_dev/models/cart_item.dart';
import 'package:heymachi_dev/screens/billing/cart_page.dart';
import 'package:heymachi_dev/utils/app_session.dart';
import 'package:restaurant_addon/screens/billing/restaurant_item_catalog_page.dart';
import '../../services/restaurant_api.dart';
import 'package:restaurant_addon/widgets/restaurant_order_meta_display.dart';

class RestaurantCartPage extends StatelessWidget {
  final Map<String, Map<String, dynamic>> cartItems;
  final Map<String, dynamic>? initialOrder;
  final bool fromOpenOrder;
  final void Function(Map<String, Map<String, dynamic>>)? onCartUpdated;

  const RestaurantCartPage({
    super.key,
    required this.cartItems,
    this.initialOrder,
    this.fromOpenOrder = false,
    this.onCartUpdated,
  });

  Future<void> _ensureTokenIfNeeded() async {
    final data = AppSession.instance.sessionData;
    final mode = data['dining_mode'];

    if ((mode == 'Takeaway' || mode == 'Delivery') && !data.containsKey('token_no')) {
      final prefix = mode == 'Takeaway' ? 'TK' : 'DL';
      final token = await RestaurantApi.getTokenForType(prefix);
      data['token_no'] = token;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _ensureTokenIfNeeded(),
      builder: (_, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }

        return CartPage(
          cartItems: cartItems,
          onCartUpdated: onCartUpdated ?? (_) {},
          initialOrder: initialOrder,
          fromOpenOrder: fromOpenOrder,
          metaDisplayOverride: const RestaurantOrderMetaDisplay(),

          // 👇 override the Item Catalog opener
          openItemCatalog: (context, localItems, orderId) async {
            final List<CartItem> cartItemList = [];

            for (var entry in localItems.entries) {
              final item = entry.value;
              cartItemList.add(
                CartItem(
                  productId: entry.key,
                  name: item['name'] ?? '',
                  price: (item['price'] ?? 0).toDouble(),
                  quantity: item['quantity'] ?? 1,
                ),
              );
            }

            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RestaurantItemCatalogPage(
                  initialCartItems: cartItemList,
                  openOrderId: orderId,
                ),
              ),
            );

            return result; // should be {'cartItems': ..., 'id': ...}
          },
        );
      },
    );
  }
}
