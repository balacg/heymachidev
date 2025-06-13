// lib/screens/master/product_master_screen.dart

import 'package:flutter/material.dart';
import '../../services/api.dart';
import '../../models/product.dart';
import '../../models/category.dart';
import '../../models/subcategory.dart';
import '../../models/tax.dart';
import '../../widgets/table_column.dart';
import '../../widgets/generic_data_table.dart';

class ProductMasterScreen extends StatefulWidget {
  const ProductMasterScreen({Key? key}) : super(key: key);

  @override
  State<ProductMasterScreen> createState() => _ProductMasterScreenState();
}

class _ProductMasterScreenState extends State<ProductMasterScreen> {
  List<Product> _products = [];
  List<Product> _allProducts = [];
  List<Category> _categories = [];
  List<Subcategory> _subcategories = [];
  List<Tax> _taxes = [];

  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadAllData();
  }

  Future<void> _loadAllData() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      _categories = await ApiService.fetchCategories();
      _taxes = await ApiService.fetchTaxes();
      final list = await ApiService.fetchProducts();
      _allProducts = list;
      _products = list;
    } catch (e) {
      _error = e.toString();
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void _deleteProduct(int id) async {
    try {
      await ApiService.deleteProduct(id);
      _loadAllData();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Delete failed: $e')));
    }
  }

  void _onSort(String field, bool asc) {
    setState(() {
      _products.sort((a, b) {
        switch (field) {
          case 'id':
            return asc ? a.id.compareTo(b.id) : b.id.compareTo(a.id);
          case 'name':
            return asc ? a.name.compareTo(b.name) : b.name.compareTo(a.name);
          case 'price':
            return asc ? a.price.compareTo(b.price) : b.price.compareTo(a.price);
          case 'categoryName':
            return asc ? a.categoryName.compareTo(b.categoryName) : b.categoryName.compareTo(a.categoryName);
          default:
            return 0;
        }
      });
    });
  }

  void _onFilter(String field, String query) {
    setState(() {
      _products = _allProducts.where((p) {
        switch (field) {
          case 'name':
            return p.name.toLowerCase().contains(query.toLowerCase());
          case 'categoryName':
            return p.categoryName.toLowerCase().contains(query.toLowerCase());
          default:
            return false;
        }
      }).toList();
    });
  }

  void _showForm({Product? product}) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController(text: product?.name ?? '');
    final priceController = TextEditingController(text: product?.price.toString() ?? '');
    int? selectedCategoryId = product?.categoryId;
    int? selectedSubcategoryId = product?.subcategoryId;
    int? selectedGstId = product?.gstId;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(product == null ? 'Add Product' : 'Edit Product'),
        content: StatefulBuilder(
          builder: (context, setModalState) => Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Product Name'),
                  validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Price'),
                  validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                ),
                DropdownButtonFormField<int>(
                  value: selectedCategoryId,
                  items: _categories.map((c) => DropdownMenuItem(value: c.id, child: Text(c.name))).toList(),
                  onChanged: (val) async {
                    setModalState(() => selectedCategoryId = val);
                    final subs = await ApiService.fetchSubcategories(categoryId: val!);
                    setModalState(() => _subcategories = subs);
                  },
                  decoration: const InputDecoration(labelText: 'Category'),
                  validator: (val) => val == null ? 'Select Category' : null,
                ),
                DropdownButtonFormField<int>(
                  value: selectedSubcategoryId,
                  items: _subcategories.map((s) => DropdownMenuItem(value: s.id, child: Text(s.name))).toList(),
                  onChanged: (val) => setModalState(() => selectedSubcategoryId = val),
                  decoration: const InputDecoration(labelText: 'Subcategory'),
                ),
                DropdownButtonFormField<int>(
                  value: selectedGstId,
                  items: _taxes.map((t) {
                    final label = '${t.type} (${t.rate.toStringAsFixed(1)}%)';
                    return DropdownMenuItem(value: t.id, child: Text(label));
                  }).toList(),
                  onChanged: (val) => setModalState(() => selectedGstId = val),
                  decoration: const InputDecoration(labelText: 'GST'),
                  validator: (val) => val == null ? 'Select GST' : null,
                ),
              ]),
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState?.validate() ?? false) {
                final newProduct = Product(
                  id: product?.id ?? 0,
                  name: nameController.text.trim(),
                  price: double.tryParse(priceController.text) ?? 0,
                  categoryId: selectedCategoryId,
                  subcategoryId: selectedSubcategoryId,
                  gstId: selectedGstId,
                  categoryName: '', // not needed on post
                );
                try {
                  if (product == null) {
                    await ApiService.createProduct(newProduct);
                  } else {
                    await ApiService.updateProduct(newProduct);
                  }
                  Navigator.pop(context);
                  _loadAllData();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed: $e')));
                }
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  String _getGstLabel(int? gstId) {
    final tax = _taxes.firstWhere((t) => t.id == gstId, orElse: () => Tax(id: 0, type: '', rate: 0));
    return tax.id == 0 ? '' : '${tax.type} (${tax.rate.toStringAsFixed(1)}%)';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Master')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Error: $_error'))
              : GenericDataTable<Product>(
                  columns: [
                    TableColumn<Product>(
                      title: 'No.',
                      field: 'no',
                      cellBuilder: (p) => Text('${_products.indexOf(p) + 1}'),
                      frozen: true,
                    ),
                    TableColumn<Product>(
                      title: 'ID',
                      field: 'id',
                      sortable: true,
                      frozen: true,
                      cellBuilder: (p) => Text('${p.id}'),
                    ),
                    TableColumn<Product>(
                      title: 'Name',
                      field: 'name',
                      sortable: true,
                      filterable: true,
                    ),
                    TableColumn<Product>(
                      title: 'Price',
                      field: 'price',
                      sortable: true,
                      cellBuilder: (p) => Text('₹${p.price.toStringAsFixed(2)}'),
                    ),
                    TableColumn<Product>(
                      title: 'Category',
                      field: 'categoryName',
                      sortable: true,
                      filterable: true,
                      cellBuilder: (p) => Text(p.categoryName),
                    ),
                    TableColumn<Product>(
                      title: 'GST',
                      field: 'gst',
                      cellBuilder: (p) => Text(_getGstLabel(p.gstId)),
                    ),
                    TableColumn<Product>(
                      title: 'Actions',
                      field: 'actions',
                      cellBuilder: (p) => PopupMenuButton<String>(
                        onSelected: (v) {
                          if (v == 'edit') _showForm(product: p);
                          else if (v == 'delete') _deleteProduct(p.id);
                        },
                        itemBuilder: (_) => const [
                          PopupMenuItem(value: 'edit', child: Text('Edit')),
                          PopupMenuItem(value: 'delete', child: Text('Delete')),
                        ],
                      ),
                    ),
                  ],
                  rows: _products,
                  onSort: _onSort,
                  onFilter: _onFilter,
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
