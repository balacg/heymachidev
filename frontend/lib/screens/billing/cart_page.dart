// lib/screens/billing/cart_page.dart

import 'package:flutter/material.dart';
import 'final_billing_page.dart';

class CartPage extends StatefulWidget {
  final Map<String, Map<String, dynamic>> cartItems;
  final void Function(Map<String, Map<String, dynamic>>) onCartUpdated;

  const CartPage({
    Key? key,
    required this.cartItems,
    required this.onCartUpdated,
  }) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Map<String, Map<String, dynamic>> _local;

  @override
  void initState() {
    super.initState();
    _local = Map.from(widget.cartItems);
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

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.iconTheme.color,
        leading: IconButton(
          icon:
              Icon(Icons.arrow_back, color: theme.iconTheme.color),
          onPressed: () {
            widget.onCartUpdated(_local);
            Navigator.pop(context);
          },
        ),
        title: const Text('Cart Summary'),
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
                        title: Text(key,
                            style: theme.textTheme.bodyLarge),
                        subtitle: Text(
                            '₹${price.toStringAsFixed(0)} x $qty',
                            style: theme.textTheme.bodyMedium),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              color: Colors.black,
                              onPressed: () {
                                setState(() {
                                  if (qty > 1) {
                                    _local[key]!['qty'] = qty - 1;
                                  } else {
                                    _local.remove(key);
                                  }
                                });
                              },
                            ),
                            Text('$qty',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            IconButton(
                              icon: const Icon(Icons.add),
                              color: Colors.black,
                              onPressed: () {
                                setState(() {
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
                  child: GestureDetector(
                    onTap: () {
                      widget.onCartUpdated(_local);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              FinalBillingPage(cartItems: _local),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [
                              Colors.deepOrange,
                              Colors.pinkAccent
                            ]),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Proceed | ₹$totalAmount',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
