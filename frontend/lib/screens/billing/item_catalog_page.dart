// lib/screens/billing/item_catalog_page.dart

import 'package:flutter/material.dart';
import '../../services/api.dart';
import 'cart_page.dart';

class ItemCatalogPage extends StatefulWidget {
  const ItemCatalogPage({Key? key}) : super(key: key);

  @override
  State<ItemCatalogPage> createState() => _ItemCatalogPageState();
}

class _ItemCatalogPageState extends State<ItemCatalogPage> {
  List<Product> _products = [];
  Map<String, Map<String, dynamic>> _cartItems = {};

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      _products = await ApiService.fetchProducts();
      setState(() {});
    } catch (e) {
      debugPrint('Error fetching products: $e');
    }
  }

  void _add(Product p) {
    setState(() {
      final name = p.name;
      if (_cartItems.containsKey(name)) {
        _cartItems[name]!['qty'] += 1;
      } else {
        _cartItems[name] = {'price': p.price, 'qty': 1};
      }
    });
  }

  void _dec(Product p) {
    setState(() {
      final name = p.name;
      final q = _cartItems[name]!['qty'] as int;
      if (q > 1) {
        _cartItems[name]!['qty'] = q - 1;
      } else {
        _cartItems.remove(name);
      }
    });
  }

  int get totalItems =>
      _cartItems.values.fold(0, (sum, v) => sum + (v['qty'] as int));

  int get totalAmount {
    return _cartItems.entries.fold<int>(
      0,
      (sum, entry) {
        final price = entry.value['price'] as double;
        final qty = entry.value['qty'] as int;
        return sum + (price * qty).toInt();
      },
    );
  }

  void _goToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CartPage(
          cartItems: _cartItems,
          onCartUpdated: (updated) {
            setState(() {
              _cartItems = Map.from(updated);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back,
                        color: theme.iconTheme.color),
                    onPressed: () =>
                        Navigator.pushNamed(context, '/dashboard'),
                  ),
                  const SizedBox(width: 8),
                  Text('Item Catalog',
                      style: theme.textTheme.titleLarge!
                          .copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            // Products
            Expanded(
              child: ListView.builder(
                itemCount: _products.length,
                itemBuilder: (_, i) {
                  final p = _products[i];
                  final qty =
                      (_cartItems[p.name]?['qty'] as int?) ?? 0;

                  return ListTile(
                    tileColor: theme.cardColor,
                    title:
                        Text(p.name, style: theme.textTheme.bodyLarge),
                    subtitle: Text('₹${p.price.toStringAsFixed(0)}',
                        style: theme.textTheme.bodyMedium),
                    trailing: qty > 0
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                color: Colors.black,
                                onPressed: () => _dec(p),
                              ),
                              Text('$qty',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              IconButton(
                                icon: const Icon(Icons.add),
                                color: Colors.black,
                                onPressed: () => _add(p),
                              ),
                            ],
                          )
                        : GestureDetector(
                            onTap: () => _add(p),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Colors.deepOrange,
                                    Colors.pinkAccent
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'ADD',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: totalItems > 0
          ? SafeArea(
              child: GestureDetector(
                onTap: _goToCart,
                child: Container(
                  height: 70,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 12),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.deepOrange, Colors.pinkAccent],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$totalItems item(s) | ₹$totalAmount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(Icons.arrow_forward,
                          color: Colors.white),
                    ],
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
