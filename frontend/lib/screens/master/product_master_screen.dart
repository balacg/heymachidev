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
      _loadProducts();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Delete failed: $e')));
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
            return asc
                ? a.categoryName.compareTo(b.categoryName)
                : b.categoryName.compareTo(a.categoryName);
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
            return p.categoryName
                .toLowerCase()
                .contains(query.toLowerCase());
          default:
            return false;
        }
      }).toList();
    });
  }

  void _showForm({Product? product}) {
    // ← your existing add/edit dialog code
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
                      cellBuilder: (p) =>
                          Text('₹${p.price.toStringAsFixed(2)}'),
                    ),
                    TableColumn<Product>(
                      title: 'Category',
                      field: 'categoryName',
                      sortable: true,
                      filterable: true,
                      cellBuilder: (p) => Text(p.categoryName),
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
