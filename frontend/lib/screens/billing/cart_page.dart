// lib/screens/billing/cart_page.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:heymachi_dev/screens/billing/item_catalog_page.dart';
import 'package:heymachi_dev/utils/app_session.dart';
import 'package:heymachi_dev/utils/industry_config.dart';
import 'package:intl/intl.dart';
import '../../services/api.dart';
import '../../widgets/order_meta_display.dart';

class CartPage extends StatefulWidget {
  final Map<String, Map<String, dynamic>> cartItems;
  final void Function(Map<String, Map<String, dynamic>>)? onCartUpdated;
  final Future<Map<String, Map<String, dynamic>>?> Function(
      BuildContext context,
      Map<String, Map<String, dynamic>> cartItems,
      String? orderId)? openItemCatalog;
  final bool fromOpenOrder;
  final Map<String, dynamic>? initialOrder;
  final Widget? metaDisplayOverride;

  const CartPage({
    Key? key,
    required this.cartItems,
    required this.onCartUpdated,
    this.openItemCatalog,
    this.fromOpenOrder = false,
    this.initialOrder,
    this.metaDisplayOverride,
  }) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Map<String, Map<String, dynamic>> _local;
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    if (widget.cartItems.isNotEmpty) {
      _local = Map.from(widget.cartItems);
      _hasChanges = true;
    } else if (widget.fromOpenOrder && widget.initialOrder != null) {
      final items = widget.initialOrder!['items'] as List<dynamic>? ?? [];
      _local = {
        for (var it in items)
          it['item']: {'price': it['price'], 'qty': it['qty']}
      };
      _hasChanges = false;
    } else {
      _local = {};
      _hasChanges = false;
    }
  }

  bool _deepEquals(a, b) {
    if (a.length != b.length) return false;
    for (var k in a.keys) {
      if (!b.containsKey(k) || !mapEquals(a[k], b[k])) return false;
    }
    return true;
  }

  Future<void> _openItemCatalogWithCart() async {
    final updated = widget.openItemCatalog != null
        ? await widget.openItemCatalog!(
            context, _local, widget.initialOrder?['id'])
        : await Navigator.push<Map<String, Map<String, dynamic>>>(
            context,
            MaterialPageRoute(
              builder: (_) => const ItemCatalogPage(isSelectorMode: false),
              settings: RouteSettings(
                arguments: {
                  'cartItems': _local,
                  'id': widget.initialOrder?['id'],
                },
              ),
            ),
          );

    if (updated != null && mounted) {
      final changed = !_deepEquals(_local, updated);
      setState(() {
        _local = updated;
        _hasChanges = changed;
      });
    }
  }

  int get totalAmount => _local.entries.fold<int>(
      0,
      (sum, e) =>
          sum + ((e.value['price'] as double) * (e.value['qty'] as int)).toInt());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fmt = NumberFormat.decimalPattern('en_IN');

    final sessionMap = widget.fromOpenOrder && widget.initialOrder != null
        ? widget.initialOrder!.map((k, v) => MapEntry(k, v.toString()))
        : AppSession.instance.sessionData
            .map((k, v) => MapEntry(k, v.toString()));
    final fieldMap = (IndustryConfig.forIndustry(
                    AppSession.instance.industryId ?? '')?['sessionFields']
                as Map?)
            ?.cast<String, String>() ??
        {};

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.iconTheme.color,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
          onPressed: () {
            widget.onCartUpdated?.call(_local);
            Navigator.pop<bool>(context, true);
          },
        ),
        title: const Text('Cart'),
      ),
      body: _local.isEmpty
          ? Center(
              child: Text(
                'Your cart is empty',
                style: theme.textTheme.bodyMedium!
                    .copyWith(color: theme.hintColor),
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: widget.metaDisplayOverride ??
                      OrderMetaDisplay(
                        style: const TextStyle(
                            fontSize: 12, color: Colors.black),
                        sessionData: sessionMap,
                        sessionLabels: fieldMap,
                      ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _local.length,
                    itemBuilder: (_, i) {
                      final key = _local.keys.elementAt(i);
                      final itm = _local[key]!;
                      final price = itm['price'] as double;
                      final qty = itm['qty'] as int;
                      return ListTile(
                        tileColor: theme.cardColor,
                        title: Text(key, style: theme.textTheme.bodyLarge),
                        subtitle: Text(
                          '₹${fmt.format(price)}  ×  $qty',
                          style: theme.textTheme.bodyMedium,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  _hasChanges = true;
                                  if (qty > 1) {
                                    itm['qty'] = qty - 1;
                                  } else {
                                    _local.remove(key);
                                  }
                                });
                              },
                            ),
                            Text('$qty',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        theme.colorScheme.onSurface)),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  _hasChanges = true;
                                  itm['qty'] = qty + 1;
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: _openItemCatalogWithCart,
                      ),
                      const SizedBox(width: 8),
                      // SAVE BUTTON
                      Expanded(
                        child: ElevatedButton(
                          onPressed: (_hasChanges && _local.isNotEmpty)
                              ? () async {
                                  widget.onCartUpdated?.call(_local);
                                  await AppSession.instance
                                      .ensureRestaurantTokenIfNeeded();

                                  final sessionData =
                                      Map<String, dynamic>.from(
                                          AppSession.instance
                                              .sessionData);
                                  final payload = {
                                    ...sessionData,
                                    'items': _local.entries
                                        .map((e) => {
                                              'item': e.key,
                                              'qty': e.value['qty'],
                                              'price':
                                                  e.value['price']
                                            })
                                        .toList(),
                                    'total_amount':
                                        totalAmount,
                                    if (widget.fromOpenOrder &&
                                        widget.initialOrder?['id'] !=
                                            null)
                                      'id':
                                          widget.initialOrder!['id'],
                                  };

                                  if (AppSession.instance
                                          .orderSaveHandler !=
                                      null) {
                                    await AppSession.instance
                                        .orderSaveHandler!
                                        .call({
                                      'cartItems': _local,
                                      'id': widget.initialOrder?[
                                          'id'],
                                    });
                                  } else {
                                    await ApiService.post(
                                        '/open-orders/',
                                        payload);
                                  }
                                  debugPrint('🛑 [CartPage] about to pop CartPage → back to Orders (mounted=$mounted)');
                                  // **THIS POPS BACK TO OrdersScreen**
                                  if (context.mounted) {
                                    Navigator.pop<bool>(
                                        context, true);
                                  }
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.deepPurple),
                          child: const Text('Save',
                              style: TextStyle(
                                  color: Colors.white)),
                        ),
                      ),

                      // CLEAR ORDER (only on edits)
                      if (widget.fromOpenOrder) ...[
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () async {
                            final confirm =
                                await showDialog<bool>(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text(
                                    'Clear this order?'),
                                content: const Text(
                                  'Are you sure you want to clear all items from this order?',
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.pop(
                                              context,
                                              false),
                                      child:
                                          const Text('Cancel')),
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.pop(
                                              context,
                                              true),
                                      child: const Text(
                                          'Clear')),
                                ],
                              ),
                            );
                            if (confirm == true) {
                              if (AppSession.instance
                                      .orderCancelHandler !=
                                  null) {
                                await AppSession.instance
                                    .orderCancelHandler!(
                                        context);
                              }
                              setState(() {
                                _local.clear();
                                _hasChanges = true;
                              });
                              widget.onCartUpdated
                                  ?.call(_local);
                              if (context.mounted) {
                                Navigator.pop<bool>(
                                    context, true);
                              }
                            }
                          },
                          style:
                              ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.redAccent),
                          child: const Text(
                              'Clear Order',
                              style: TextStyle(
                                  color: Colors.white)),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
