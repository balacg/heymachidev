// lib/screens/restaurant/menu_category_screen.dart

import 'package:flutter/material.dart';
import '../../models/restaurant/menu_category.dart';
import '../../services/restaurant/menu_category_service.dart';
import '../../widgets/generic_data_table.dart';
import '../../widgets/table_column.dart';

class MenuCategoryScreen extends StatefulWidget {
  const MenuCategoryScreen({Key? key}) : super(key: key);

  @override
  State<MenuCategoryScreen> createState() => _MenuCategoryScreenState();
}

class _MenuCategoryScreenState extends State<MenuCategoryScreen> {
  List<MenuCategory> _categories = [];
  List<MenuCategory> _allCategories = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      _allCategories = await MenuCategoryService.fetchCategories();
      _categories = List.of(_allCategories);
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

  void _showForm({MenuCategory? category}) {
    final isEdit = category != null;
    final nameCtl = TextEditingController(text: category?.name ?? '');
    final descCtl = TextEditingController(text: category?.description ?? '');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isEdit ? 'Edit Category' : 'Add Category'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtl, decoration: const InputDecoration(labelText: 'Name')),
            TextField(controller: descCtl, decoration: const InputDecoration(labelText: 'Description')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              final name = nameCtl.text.trim();
              final desc = descCtl.text.trim();

              if (name.isEmpty) return;

              final model = MenuCategory(
                id: category?.id ?? '',
                name: name,
                description: desc,
                isActive: true,
              );

              try {
                if (isEdit) {
                  await MenuCategoryService.updateCategory(model);
                } else {
                  await MenuCategoryService.createCategory(model);
                }
                Navigator.of(ctx).pop();
                await _loadCategories();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deleteCategory(String id) async {
    try {
      await MenuCategoryService.deleteCategory(id);
      await _loadCategories();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Delete failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu Categories')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Error: $_error'))
              : GenericDataTable<MenuCategory>(
                  columns: [
                    TableColumn(title: 'Name', field: 'name', filterable: true),
                    TableColumn(title: 'Description', field: 'description'),
                    TableColumn(
                      title: 'Actions',
                      field: 'actions',
                      cellBuilder: (c) => PopupMenuButton<String>(
                        onSelected: (v) {
                          if (v == 'edit') _showForm(category: c);
                          if (v == 'delete') _deleteCategory(c.id);
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
