// lib/screens/billing/item_catalog_page.dart

import 'package:flutter/material.dart';
import 'package:heymachi_dev/models/cart_item.dart';
import 'package:heymachi_dev/models/category.dart';
import 'package:heymachi_dev/models/product.dart';
import 'package:heymachi_dev/models/subcategory.dart';
import 'package:heymachi_dev/utils/app_session.dart';
import 'package:heymachi_dev/utils/industry_config.dart';
import 'package:intl/intl.dart';
import '../../services/api.dart';
import 'cart_page.dart';
import '../../widgets/floating_menu_overlay.dart';
import '../../widgets/order_meta_display.dart';

class ItemCatalogPage extends StatefulWidget {
  final bool isSelectorMode;
  final List<CartItem>? initialCartItems; 
  final Function(List<CartItem>)? onCartConfirmed;

  const ItemCatalogPage({
    super.key,
    this.isSelectorMode = false,
    this.initialCartItems,
    this.onCartConfirmed, // ✅ ADD THIS LINE
  });

  @override
  State<ItemCatalogPage> createState() => _ItemCatalogPageState();
}

class _ItemCatalogPageState extends State<ItemCatalogPage> {
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  Map<String, Map<String, dynamic>> _cartItems = {};
  final TextEditingController _searchCtl = TextEditingController();
  bool _initialized = false;
  String? orderId;

  bool _showMenuOverlay = false;
  List<Category> _categories = [];
  List<Subcategory> _subcategories = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //loadOccupiedTables();

    if (!_initialized) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args != null && args is Map) {
        if (args.containsKey('cartItems') && args['cartItems'] is Map) {
          _cartItems = Map<String, Map<String, dynamic>>.from(
            (args['cartItems'] as Map).map(
              (key, value) => MapEntry(key.toString(), Map<String, dynamic>.from(value)),
            ),
          );
        }
        if (args.containsKey('id')) {
          orderId = args['id']?.toString();
        }
      }
      _initialized = true;
    }
  }

  Future<void> _fetchProducts() async {
    try {
      _products = await ApiService.fetchProducts();
      _filteredProducts = List.from(_products);
      _categories = await ApiService.fetchCategories();
      _subcategories = await ApiService.fetchSubcategories();
      /* for (final s in _subcategories) {
       debugPrint("🔹 Subcategory: ${s.name}, Category ID: ${s.categoryId}");
      } */
      setState(() {});

       // ✅ Debug: Print subcategories grouped under each category
      for (final cat in _categories) {
        final subs = _subcategories.where((s) => s.categoryId == cat.id).toList();
        final subNames = subs.map((s) => s.name ?? 'Unnamed').join(', ');
        //debugPrint("🍱 Category: ${cat.name ?? 'Unknown'} → Subcats: $subNames");
      }
    } catch (e) {
      debugPrint('Error fetching products: $e');
    }
  }

  void _onSearch(String query) {
    setState(() {
      _filteredProducts = _products
          .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
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

  int get totalItems => _cartItems.values.fold(0, (sum, v) => sum + (v['qty'] as int));

  String get totalAmount {
    final amount = _cartItems.entries.fold<double>(
      0,
      (sum, entry) {
        final price = entry.value['price'] as double;
        final qty = entry.value['qty'] as int;
        return sum + (price * qty);
      },
    );
    return NumberFormat.decimalPattern().format(amount);
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
          fromOpenOrder: orderId != null,
          initialOrder: {
            ...AppSession.instance.sessionData,
            if (orderId != null) 'id': orderId,
            'items': _cartItems.entries.map((e) => {
              'item': e.key,
              'qty': e.value['qty'],
              'price': e.value['price'],
            }).toList(),
            'total_amount': _cartItems.entries.fold(
              0,
              (sum, e) => sum + ((e.value['price'] as double) * (e.value['qty'] as int)).toInt(),
            ),
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final rawLabels = (IndustryConfig.forIndustry(AppSession.instance.industryId ?? '')?['sessionFields'] as Map?)?.map(
      (k, v) => MapEntry(k.toString(), v.toString()),
    ) ?? {};

    // 🧹 Hide fields with no data
    final sessionLabels = {
      for (final entry in rawLabels.entries)
        if (AppSession.instance.sessionData[entry.key]?.toString().isNotEmpty ?? false)
          entry.key: entry.value
    };

    final filteredSessionData = {
      for (final entry in AppSession.instance.sessionData.entries)
        if (sessionLabels.containsKey(entry.key) && entry.value.toString().isNotEmpty)
          entry.key: entry.value.toString()
    };

    final subcatMap = <String, List<Subcategory>>{};
    for (final sub in _subcategories) {
      final catId = sub.categoryId;
      if (catId != null) {
        subcatMap.putIfAbsent(catId, () => []).add(sub);
      }
    }

    final productCountMap = <String, int>{};
    for (final p in _products) {
      if (p.subcategoryId != null) {
        productCountMap[p.subcategoryId!] = (productCountMap[p.subcategoryId!] ?? 0) + 1;
      }
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  child: Row(
                    children: [
                      /*IconButton(
                        icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
                        onPressed: () => Navigator.pop(context, _cartItems),
                      ),
                       const SizedBox(width: 8),
                      Text('Item Catalog', style: theme.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold)), */
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: OrderMetaDisplay(
                    sessionData: filteredSessionData,
                    sessionLabels: sessionLabels,
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _filteredProducts.length,
                    itemBuilder: (_, i) {
                      final p = _filteredProducts[i];
                      final qty = (_cartItems[p.name]?['qty'] as int?) ?? 0;
                      return ListTile(
                        tileColor: theme.cardColor,
                        contentPadding:EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                        title: Text(p.name, style: theme.textTheme.bodyMedium),
                        subtitle: Text('₹${NumberFormat.decimalPattern().format(p.price)}', style: theme.textTheme.bodyMedium),
                        trailing: qty > 0
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(icon: const Icon(Icons.remove), onPressed: () => _dec(p)),
                                  Text('$qty'),
                                  IconButton(icon: const Icon(Icons.add), onPressed: () => _add(p)),
                                ],
                              )
                            : GestureDetector(
                                onTap: () {
                                  widget.isSelectorMode
                                      ? Navigator.pop(context, {'name': p.name, 'price': p.price})
                                      : _add(p);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(colors: [Colors.deepOrange, Colors.pinkAccent]),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text('ADD', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                ),
                              ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          if (_showMenuOverlay)
            Positioned.fill(
              child: FloatingMenuOverlay(
                categories: _categories,
                subcategoriesByCategory: {
                  for (final cat in _categories)
                    cat.id!: _subcategories.where((s) => s.categoryId == cat.id).toList(),
                },
                productCounts: {
                  for (final p in _products)
                    if (p.subcategoryId != null)
                      p.subcategoryId!: (_products.where((x) => x.subcategoryId == p.subcategoryId).length)
                },
                onSubcategorySelected: (subId) {
                  final selectedSub = _subcategories.firstWhere((s) => s.id == subId);
                  final filtered = _products.where((p) => p.subcategoryId == selectedSub.id).toList();
                  setState(() {
                    _filteredProducts = filtered;
                    _showMenuOverlay = false;
                  });
                },
                onClose: () => setState(() => _showMenuOverlay = false),
              ),
            )


        ],
      ),
      floatingActionButton: _showMenuOverlay
        ? null  // Hide FAB and search bar when overlay is open
        : Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 20),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TextField(
                      controller: _searchCtl,
                      onChanged: _onSearch,
                      decoration: const InputDecoration(
                        hintText: 'Search product...',
                        prefixIcon: Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                FloatingActionButton.small(
                  backgroundColor: Colors.black,
                  onPressed: () => setState(() => _showMenuOverlay = !_showMenuOverlay),
                  child: Icon(_showMenuOverlay ? Icons.close : Icons.menu),
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
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.deepOrange, Colors.pinkAccent]),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('$totalItems item(s) | ₹$totalAmount', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      const Icon(Icons.arrow_forward, color: Colors.white),
                    ],
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
