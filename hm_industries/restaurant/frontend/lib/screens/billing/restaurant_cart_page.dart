// FINAL PATCHED version of restaurant_cart_page.dart

import 'package:flutter/material.dart';
import 'package:heymachi_dev/models/cart_item.dart';
import 'package:heymachi_dev/screens/billing/cart_page.dart';
import 'package:heymachi_dev/utils/app_session.dart';
import 'package:restaurant_addon/constants/dining_types.dart';
import 'package:restaurant_addon/screens/billing/restaurant_item_catalog_page.dart';
import 'package:restaurant_addon/services/restaurant_api.dart';
import 'package:restaurant_addon/widgets/restaurant_order_meta_display.dart';

class RestaurantCartPage extends StatefulWidget {
  final Map<String, Map<String, dynamic>> cartItems;
  final Map<String, dynamic>? initialOrder;
  final bool fromOpenOrder;
  final void Function(Map<String, Map<String, dynamic>>)? onCartUpdated;

  const RestaurantCartPage({
    Key? key,
    required this.cartItems,
    this.initialOrder,
    this.fromOpenOrder = false,
    this.onCartUpdated,
  }) : super(key: key);

  @override
  State<RestaurantCartPage> createState() => _RestaurantCartPageState();
}

class _RestaurantCartPageState extends State<RestaurantCartPage> {
  bool _tokenReady = false;
  bool _didAutoOpen = false;

  @override
  void initState() {
    super.initState();
    _initSessionAndHandler();
  }

  Future<void> _initSessionAndHandler() async {
    final session = AppSession.instance.sessionData;
    final mode = session['dining_mode'];
    if ((mode == DiningTypes.takeaway || mode == DiningTypes.delivery) &&
        !session.containsKey('token_no')) {
      final prefix = mode == DiningTypes.takeaway ? 'TK' : 'DL';
      session['token_no'] = await RestaurantApi.getTokenForType(prefix);
    }

    // -- SAVE handler: saves + triggers pop back manually
    AppSession.instance.orderSaveHandler = (payload) async {
      final cartItems = payload['cartItems'] as Map<String, dynamic>;
      final orderId = payload['id'] as String?;
      final itemsList = cartItems.entries.map((e) {
        final m = e.value as Map<String, dynamic>;
        return {
          'item': e.key,
          'qty': m['qty'],
          'price': m['price'],
        };
      }).toList();
      final totalAmount = itemsList.fold<double>(
        0,
        (sum, elt) => sum + (elt['price'] as double) * (elt['qty'] as int),
      );
      final body = {
        ...AppSession.instance.sessionData,
        'items': itemsList,
        'total_amount': totalAmount,
        if (orderId != null) 'id': orderId,
      };
      await RestaurantApi.saveOpenOrder(body);

      // ✅ do not pop here — CartPage will pop after save
    };

    AppSession.instance.orderCancelHandler = (BuildContext ctx) async {
      final id = widget.initialOrder?['id'] as String?;
      if (id != null) {
        await RestaurantApi.cancelOrder(id);
      }
    };

    if (mounted) setState(() => _tokenReady = true);
  }

  @override
  Widget build(BuildContext context) {
    if (!_tokenReady) {
      return const Center(child: CircularProgressIndicator());
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ✅ only auto open if really new and empty
      if (!_didAutoOpen && widget.cartItems.isEmpty && !widget.fromOpenOrder) {
        _didAutoOpen = true;
        _openCatalogDirect();
      }
    });

    return CartPage(
      cartItems: widget.cartItems,
      onCartUpdated: widget.onCartUpdated ?? (_) {},
      initialOrder: widget.initialOrder,
      fromOpenOrder: widget.fromOpenOrder,
      metaDisplayOverride: const RestaurantOrderMetaDisplay(),
      openItemCatalog: (ctx, localItems, orderId) async {
        final initial = localItems.entries.map((e) {
          final m = e.value;
          return CartItem(
            productId: e.key,
            name: '',
            price: (m['price'] ?? 0).toDouble(),
            quantity: m['qty'] as int,
          );
        }).toList();

        final result = await Navigator.push<Map<String, Object>?>(
          ctx,
          MaterialPageRoute(
            builder: (_) => RestaurantItemCatalogPage(
              initialCartItems: initial,
              openOrderId: orderId,
            ),
          ),
        );

        if (result == null || result['cartItems'] == null) return null;

        final updated = result['cartItems'] as List<CartItem>;
        return {
          for (var c in updated) c.productId: {
            'qty': c.quantity,
            'price': c.price,
          }
        };
      },
    );
  }

  Future<void> _openCatalogDirect() async {
    final result = await Navigator.push<Map<String, Object>?>(
      context,
      MaterialPageRoute(
        builder: (_) => RestaurantItemCatalogPage(
          initialCartItems: [],
          openOrderId: widget.initialOrder?['id'],
        ),
      ),
    );
    if (mounted && result != null && result['cartItems'] != null) {
      final updated = result['cartItems'] as List<CartItem>;
      final map = {
        for (var c in updated)
          c.productId: {'qty': c.quantity, 'price': c.price}
      };
      widget.onCartUpdated?.call(map);
    }
  }
}
