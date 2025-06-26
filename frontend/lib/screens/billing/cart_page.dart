// lib/screens/billing/cart_page.dart

import 'package:flutter/material.dart';
import 'package:heymachi_dev/screens/billing/item_catalog_page.dart';
import 'package:intl/intl.dart';
import '../../utils/app_session.dart';
import '../../utils/industry_config.dart';
import 'final_billing_page.dart';
import '../../widgets/order_meta_display.dart';
import '../../services/api.dart';
import 'package:flutter/foundation.dart';

class CartPage extends StatefulWidget {
  final Map<String, Map<String, dynamic>> cartItems;
  final void Function(Map<String, Map<String, dynamic>>)? onCartUpdated;
  final Future<Map<String, Map<String, dynamic>>?> Function(BuildContext context, Map<String, Map<String, dynamic>> cartItems, String? orderId)? openItemCatalog;

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

  void _openItemCatalogWithCart() async {
    final updatedCart = widget.openItemCatalog != null
        ? await widget.openItemCatalog!(context, _local, widget.initialOrder?['id'])
        : await Navigator.push<Map<String, Map<String, dynamic>>>(
            context,
            MaterialPageRoute(
              builder: (_) => const ItemCatalogPage(isSelectorMode: false),
              settings: RouteSettings(arguments: {
                'cartItems': _local,
                'id': widget.initialOrder?['id'],
              }),
            ),
          );

    if (updatedCart != null && mounted) {
      bool hasChanges = !_deepEquals(_local, updatedCart);
      setState(() {
        _local = updatedCart;
        _hasChanges = hasChanges;
      });
    }
  }

  bool _deepEquals(Map<String, Map<String, dynamic>> a, Map<String, Map<String, dynamic>> b) {
    if (a.length != b.length) return false;
    for (final key in a.keys) {
      if (!b.containsKey(key)) return false;
      if (!mapEquals(a[key], b[key])) return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    if (widget.cartItems.isNotEmpty) {
      _local = Map.from(widget.cartItems);
      _hasChanges = true;
    } else if (widget.fromOpenOrder && widget.initialOrder != null) {
      final items = widget.initialOrder!['items'] as List<dynamic>? ?? [];
      _local = {
        for (var item in items)
          item['item']: {
            'price': item['price'],
            'qty': item['qty'],
          }
      };
      _hasChanges = false;
    } else {
      _local = {};
      _hasChanges = false;
    }
  }

  int get totalAmount {
    return _local.entries.fold<int>(
      0,
      (sum, entry) {
        final price = entry.value['price'] as double;
        final qty = entry.value['qty'] as int;
        return sum + (price * qty).toInt();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final numberFormat = NumberFormat.decimalPattern('en_IN');
    final itemColor = theme.colorScheme.onSurface;

    final sessionData = widget.fromOpenOrder && widget.initialOrder != null
        ? widget.initialOrder!.map((k, v) => MapEntry(k, v.toString()))
        : AppSession.instance.sessionData.map((k, v) => MapEntry(k, v.toString()));

    final industryId = AppSession.instance.industryId ?? '';
    final fieldMap = (IndustryConfig.forIndustry(industryId)?['sessionFields'] is Map)
        ? Map<String, String>.from(IndustryConfig.forIndustry(industryId)?['sessionFields'] ?? {})
        : <String, String>{};

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.iconTheme.color,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
          onPressed: () {
            widget.onCartUpdated?.call(_local);
            Navigator.pop(context, _local);
          },
        ),
        title: const Text('Cart'),
      ),
      body: _local.isEmpty
          ? Center(
              child: Text(
                'Your cart is empty',
                style: theme.textTheme.bodyMedium!.copyWith(color: theme.hintColor),
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: widget.metaDisplayOverride ??
                      OrderMetaDisplay(
                        style: const TextStyle(fontSize: 12, color: Colors.black),
                        sessionData: sessionData,
                        sessionLabels: fieldMap,
                      ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _local.length,
                    itemBuilder: (_, i) {
                      final key = _local.keys.elementAt(i);
                      final item = _local[key]!;
                      final price = item['price'] as double;
                      final qty = item['qty'] as int;
                      return ListTile(
                        tileColor: theme.cardColor,
                        title: Text(key, style: theme.textTheme.bodyLarge),
                        subtitle: Text('₹${numberFormat.format(price)} x $qty', style: theme.textTheme.bodyMedium),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              color: itemColor,
                              onPressed: () {
                                setState(() {
                                  _hasChanges = true;
                                  if (qty > 1) {
                                    _local[key]!['qty'] = qty - 1;
                                  } else {
                                    _local.remove(key);
                                  }
                                });
                              },
                            ),
                            Text('$qty', style: TextStyle(color: itemColor, fontWeight: FontWeight.bold)),
                            IconButton(
                              icon: const Icon(Icons.add),
                              color: itemColor,
                              onPressed: () {
                                setState(() {
                                  _hasChanges = true;
                                  _local[key]!['qty'] = qty + 1;
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
                        color: theme.iconTheme.color,
                        onPressed: _openItemCatalogWithCart,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: (_hasChanges && _local.isNotEmpty)
                              ? () async {
                                  widget.onCartUpdated?.call(_local);

                                  final sessionMap = Map<String, dynamic>.from(AppSession.instance.sessionData);
                                  await AppSession.instance.ensureRestaurantTokenIfNeeded();

                                  final orderPayload = {
                                    ...sessionMap,
                                    'items': _local.entries
                                        .map((e) => {'item': e.key, 'qty': e.value['qty'], 'price': e.value['price']})
                                        .toList(),
                                    'total_amount': totalAmount,
                                  };

                                  if (widget.fromOpenOrder && widget.initialOrder?['id'] != null) {
                                    orderPayload['id'] = widget.initialOrder!['id'];
                                  }

                                  if (AppSession.instance.orderSaveHandler != null) {
                                    await AppSession.instance.orderSaveHandler!(orderPayload);
                                  }

                                  if (context.mounted) {
                                    Navigator.pop(context, _local);
                                  }
                                }
                              : null,
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                          child: const Text('Save', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      if (widget.fromOpenOrder) ...[
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text('Clear this order?'),
                                content: const Text('Are you sure you want to clear all items from this order?'),
                                actions: [
                                  TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                                  TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Clear')),
                                ],
                              ),
                            );

                            if (confirm == true) {
                              if (AppSession.instance.orderCancelHandler != null &&
                                  widget.initialOrder?['id'] != null) {
                                await AppSession.instance.orderCancelHandler!(context);
                              }

                              setState(() {
                                _local.clear();
                                _hasChanges = true;
                              });

                              widget.onCartUpdated?.call(_local);

                              if (context.mounted) {
                                Navigator.pop(context, _local);
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                          child: const Text('Clear Order', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            widget.onCartUpdated?.call(_local);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) {
                                  final builderFn = AppSession.instance.finalBillingPageBuilder;
                                  final page = builderFn?.call(_local);
                                  return page ?? FinalBillingPage(cartItems: _local);
                                },
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                          child: Text(
                            'Billing ₹${numberFormat.format(totalAmount)}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
