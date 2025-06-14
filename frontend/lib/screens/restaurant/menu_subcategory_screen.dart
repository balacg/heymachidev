// lib/screens/restaurant/menu_subcategory_screen.dart

import 'package:flutter/material.dart';
import '../../models/restaurant/menu_subcategory.dart';
import '../../models/restaurant/menu_category.dart';
import '../../services/restaurant/menu_subcategory_service.dart';
import '../../services/restaurant/menu_category_service.dart';
import '../../widgets/generic_data_table.dart';
import '../../widgets/table_column.dart';

class MenuSubcategoryScreen extends StatefulWidget {
  const MenuSubcategoryScreen({super.key});

  @override
  State<MenuSubcategoryScreen> createState() => _MenuSubcategoryScreenState();
}

class _MenuSubcategoryScreenState extends State<MenuSubcategoryScreen> {
  List<MenuSubcategory> _subcategories = [];
  List<MenuSubcategory> _allSubcategories = [];
  List<MenuCategory> _categories = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      _categories = await MenuCategoryService.fetchCategories();
      _allSubcategories = await MenuSubcategoryService.fetchSubcategories();
      _subcategories = List.of(_allSubcategories);
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
      _subcategories.sort((a, b) {
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
      _subcategories = _allSubcategories.where((s) {
        final val = s.toJson()[field]?.toString().toLowerCase() ?? '';
        return val.contains(query.toLowerCase());
      }).toList();
    });
  }

  void _showForm({MenuSubcategory? sub}) {
    final isEdit = sub != null;
    final nameCtl = TextEditingController(text: sub?.name ?? '');
    String selectedCategoryId = sub?.categoryId ?? (_categories.isNotEmpty ? _categories.first.id : '');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isEdit ? 'Edit Subcategory' : 'Add Subcategory'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: selectedCategoryId,
              items: _categories.map((c) {
                return DropdownMenuItem(value: c.id, child: Text(c.name));
              }).toList(),
              onChanged: (val) {
                selectedCategoryId = val!;
              },
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            TextField(controller: nameCtl, decoration: const InputDecoration(labelText: 'Subcategory Name')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              if (nameCtl.text.trim().isEmpty || selectedCategoryId.isEmpty) return;
              final category = _categories.firstWhere((c) => c.id == selectedCategoryId);
              final model = MenuSubcategory(
                id: sub?.id ?? '',
                name: nameCtl.text.trim(),
                categoryId: selectedCategoryId,
                categoryName: category.name,
                isActive: true,
              );

              try {
                if (isEdit) {
                  await MenuSubcategoryService.updateSubcategory(model);
                } else {
                  await MenuSubcategoryService.createSubcategory(model);
                }
                Navigator.of(ctx).pop();
                await _loadData();
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

  void _deleteSubcategory(String id) async {
    try {
      await MenuSubcategoryService.deleteSubcategory(id);
      await _loadData();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Delete failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu Subcategories')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Error: $_error'))
              : GenericDataTable<MenuSubcategory>(
                  columns: [
                    TableColumn(title: 'Name', field: 'name', filterable: true),
                    TableColumn(title: 'Category', field: 'categoryName'),
                    TableColumn(
                      title: 'Actions',
                      field: 'actions',
                      cellBuilder: (c) => PopupMenuButton<String>(
                        onSelected: (v) {
                          if (v == 'edit') _showForm(sub: c);
                          if (v == 'delete') _deleteSubcategory(c.id);
                        },
                        itemBuilder: (_) => const [
                          PopupMenuItem(value: 'edit', child: Text('Edit')),
                          PopupMenuItem(value: 'delete', child: Text('Delete')),
                        ],
                      ),
                    ),
                  ],
                  rows: _subcategories,
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
