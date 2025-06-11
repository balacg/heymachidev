// lib/screens/master/category_master_screen.dart

import 'package:flutter/material.dart';
import '../../services/api.dart';
import '../../models/category.dart';
import '../../models/tax.dart';
import '../../widgets/table_column.dart';
import '../../widgets/generic_data_table.dart';

class CategoryMasterScreen extends StatefulWidget {
  const CategoryMasterScreen({Key? key}) : super(key: key);

  @override
  State<CategoryMasterScreen> createState() => _CategoryMasterScreenState();
}

class _CategoryMasterScreenState extends State<CategoryMasterScreen> {
  List<Category> _categories    = [];
  List<Category> _allCategories = [];
  List<Tax>      _taxes         = [];
  bool           _loading       = true;
  String?        _error;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _loading = true;
      _error   = null;
    });
    try {
      _taxes       = await ApiService.fetchTaxes();
      _allCategories = await ApiService.fetchCategories();
      _categories    = List.of(_allCategories);
    } catch (e) {
      _error = e.toString();
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void _onSort(String field, bool asc) {
    setState(() {
      _categories.sort((a, b) {
        final va = a.toJson()[field];
        final vb = b.toJson()[field];
        if (va is Comparable && vb is Comparable) {
          return asc ? va.compareTo(vb) : vb.compareTo(va);
        }
        return 0;
      });
    });
  }

  void _onFilter(String field, String query) {
    setState(() {
      _categories = _allCategories.where((c) {
        final val = c.toJson()[field]?.toString().toLowerCase() ?? '';
        return val.contains(query.toLowerCase());
      }).toList();
    });
  }

  void _showForm({Category? category}) {
    final isEdit  = category != null;
    final nameCtl = TextEditingController(text: category?.name ?? '');
    Tax? selectedTax = isEdit
        ? _taxes.firstWhere((t) => t.id == category!.gstId,
            orElse: () => Tax(id: 0, rate: 0.0, type: 'None'))
        : null;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isEdit ? 'Edit Category' : 'Add Category'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtl,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<Tax>(
              decoration: const InputDecoration(labelText: 'GST Slab'),
              value: selectedTax,
              items: _taxes
                  .map((t) => DropdownMenuItem(
                        value: t,
                        child: Text('${t.rate.toStringAsFixed(2)}%'),
                      ))
                  .toList(),
              onChanged: (t) => selectedTax = t,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final name = nameCtl.text.trim();
              if (name.isEmpty || selectedTax == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please fill all fields')),
                );
                return;
              }
              final model = Category(
                id:    category?.id ?? 0,
                name:  name,
                gstId: selectedTax!.id,
              );
              try {
                if (isEdit) {
                  await ApiService.updateCategory(model);
                } else {
                  await ApiService.createCategory(model);
                }
                Navigator.of(ctx).pop();
              } catch (e) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Error: $e')));
              }
              await _loadData();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deleteCategory(int id) async {
    try {
      await ApiService.deleteCategory(id);
      await _loadData();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Delete failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Category Master')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Error: $_error'))
              : GenericDataTable<Category>(
                  columns: [
                    TableColumn<Category>(
                      title: 'ID',
                      field: 'id',
                      sortable: true,
                      frozen: true,
                      cellBuilder: (c) => Text('${c.id}'),
                    ),
                    TableColumn<Category>(
                      title: 'Name',
                      field: 'name',
                      sortable: true,
                      filterable: true,
                    ),
                    TableColumn<Category>(
                      title: 'GST %',
                      field: 'gstId',
                      cellBuilder: (c) {
                        final tax = _taxes.firstWhere(
                          (t) => t.id == c.gstId,
                          orElse: () => Tax(id: 0, rate: 0.0, type: 'None'),
                        );
                        return Text('${tax.rate.toStringAsFixed(2)}%');
                      },
                    ),
                    TableColumn<Category>(
                      title: 'Actions',
                      field: 'actions',
                      cellBuilder: (c) => PopupMenuButton<String>(
                        onSelected: (v) {
                          if (v == 'edit') {
                            _showForm(category: c);
                          } else {
                            _deleteCategory(c.id);
                          }
                        },
                        itemBuilder: (_) => const [
                          PopupMenuItem(value: 'edit', child: Text('Edit')),
                          PopupMenuItem(value: 'delete', child: Text('Delete')),
                        ],
                      ),
                    ),
                  ],
                  rows: _categories,
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
