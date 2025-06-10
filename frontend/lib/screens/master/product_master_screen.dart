// lib/screens/master/product_master_screen.dart

import 'package:flutter/material.dart';
import '../../services/api.dart';
import '../../models/product.dart';
import '../../models/category.dart';
import '../../models/subcategory.dart';
import '../../models/tax.dart';

class ProductMasterScreen extends StatefulWidget {
  const ProductMasterScreen({Key? key}) : super(key: key);

  @override
  State<ProductMasterScreen> createState() => _ProductMasterScreenState();
}

class _ProductMasterScreenState extends State<ProductMasterScreen> {
  List<Product> _products = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      _products = await ApiService.fetchProducts();
    } catch (e) {
      _error = e.toString();
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _deleteProduct(int id) async {
    try {
      await ApiService.deleteProduct(id);
      _loadProducts();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Delete failed: $e')),
      );
    }
  }

  Future<void> _showForm({Product? product}) async {
    final isEdit = product != null;

    // Controllers
    final nameCtrl  = TextEditingController(text: product?.name ?? '');
    final priceCtrl = TextEditingController(text: product?.price.toString() ?? '');

    // Lookup lists & current selections
    List<Category> categories   = [];
    List<Subcategory> subcategories = [];
    List<Tax> taxes             = [];
    int? selectedCat            = product?.categoryId;
    int? selectedSub            = product?.subcategoryId;
    int? selectedGst            = product?.gstId;

    // Fetch categories, subcategories, taxes
    try {
      categories = await ApiService.fetchCategories();
      taxes      = await ApiService.fetchTaxes();
      if (selectedCat != null) {
        subcategories =
            await ApiService.fetchSubcategories(categoryId: selectedCat);
      }
    } catch (_) {}

    await showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: Text(isEdit ? 'Edit Product' : 'Add Product'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: priceCtrl,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<int>(
                  value: selectedCat,
                  decoration: const InputDecoration(labelText: 'Category'),
                  items: categories
                      .map((c) =>
                          DropdownMenuItem(value: c.id, child: Text(c.name)))
                      .toList(),
                  onChanged: (val) async {
                    setState(() {
                      selectedCat = val;
                      selectedSub = null;
                      subcategories = [];
                    });
                    if (val != null) {
                      final subs = await ApiService.fetchSubcategories(
                          categoryId: val);
                      setState(() => subcategories = subs);
                    }
                  },
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<int>(
                  value: selectedSub,
                  decoration: const InputDecoration(labelText: 'Subcategory'),
                  items: subcategories
                      .map((s) =>
                          DropdownMenuItem(value: s.id, child: Text(s.name)))
                      .toList(),
                  onChanged: (val) => setState(() => selectedSub = val),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<int>(
                  value: selectedGst,
                  decoration: const InputDecoration(labelText: 'GST Rate'),
                  items: taxes
                      .map((t) => DropdownMenuItem(
                            value: t.id,
                            child: Text('${t.type} (${t.rate}%)'),
                          ))
                      .toList(),
                  onChanged: (val) => setState(() => selectedGst = val),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final model = Product(
                  id:            product?.id ?? 0,
                  name:          nameCtrl.text,
                  price:         double.tryParse(priceCtrl.text) ?? 0.0,
                  categoryName:  product?.categoryName ?? '',
                  categoryId:    selectedCat,
                  subcategoryId: selectedSub,
                  gstId:         selectedGst,
                );

                Navigator.of(ctx).pop();

                try {
                  if (isEdit) {
                    await ApiService.updateProduct(model);
                  } else {
                    await ApiService.createProduct(model);
                  }
                  _loadProducts();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Save failed: $e')),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const headerStyle = TextStyle(fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBar(title: const Text('Product Master')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Error: $_error'))
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor:
                        MaterialStateProperty.all(Colors.grey[200]),
                    columns: const [
                      DataColumn(label: Text('No.', style: headerStyle)),
                      DataColumn(label: Text('ID', style: headerStyle)),
                      DataColumn(label: Text('Name', style: headerStyle)),
                      DataColumn(label: Text('Price', style: headerStyle)),
                      DataColumn(label: Text('Category', style: headerStyle)),
                      DataColumn(label: Text('Actions', style: headerStyle)),
                    ],
                    rows: List<DataRow>.generate(_products.length, (i) {
                      final p = _products[i];
                      return DataRow(cells: [
                        DataCell(Text('${i + 1}')),
                        DataCell(Text('${p.id}')),
                        DataCell(Text(p.name)),
                        DataCell(Text('₹${p.price.toStringAsFixed(2)}')),
                        DataCell(Text(p.categoryName)),
                        DataCell(
                          PopupMenuButton<String>(
                            onSelected: (v) {
                              if (v == 'edit') {
                                _showForm(product: p);
                              } else if (v == 'delete') {
                                _deleteProduct(p.id);
                              }
                            },
                            itemBuilder: (_) => const [
                              PopupMenuItem(value: 'edit', child: Text('Edit')),
                              PopupMenuItem(
                                  value: 'delete', child: Text('Delete')),
                            ],
                          ),
                        ),
                      ]);
                    }),
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
