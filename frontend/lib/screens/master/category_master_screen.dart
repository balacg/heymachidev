// lib/screens/master/category_master_screen.dart

import 'package:flutter/material.dart';
import '../../services/api.dart';
import '../../models/category.dart';

class CategoryMasterScreen extends StatefulWidget {
  const CategoryMasterScreen({Key? key}) : super(key: key);

  @override
  State<CategoryMasterScreen> createState() => _CategoryMasterScreenState();
}

class _CategoryMasterScreenState extends State<CategoryMasterScreen> {
  List<Category> _categories = [];
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
      _categories = await ApiService.fetchCategories();
    } catch (e) {
      _error = e.toString();
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void _showForm({Category? category}) {
    final isEdit = category != null;
    final nameCtrl = TextEditingController(text: category?.name ?? '');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isEdit ? 'Edit Category' : 'Add Category'),
        content: TextField(
          controller: nameCtrl,
          decoration: const InputDecoration(labelText: 'Name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final model = Category(
                id: category?.id ?? 0,
                name: nameCtrl.text,
              );
              Navigator.of(ctx).pop();
              if (isEdit) {
                await ApiService.updateCategory(model);
              } else {
                await ApiService.createCategory(model);
              }
              _loadCategories();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deleteCategory(int id) async {
    await ApiService.deleteCategory(id);
    _loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    const headerStyle = TextStyle(fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBar(title: const Text('Category Master')),
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
                      DataColumn(label: Text('Actions', style: headerStyle)),
                    ],
                    rows: List<DataRow>.generate(_categories.length, (i) {
                      final cat = _categories[i];
                      return DataRow(cells: [
                        DataCell(Text('${i + 1}')),
                        DataCell(Text('${cat.id}')),
                        DataCell(Text(cat.name)),
                        DataCell(
                          PopupMenuButton<String>(
                            onSelected: (v) {
                              if (v == 'edit') _showForm(category: cat);
                              else if (v == 'delete') _deleteCategory(cat.id);
                            },
                            itemBuilder: (_) => const [
                              PopupMenuItem(value: 'edit', child: Text('Edit')),
                              PopupMenuItem(value: 'delete', child: Text('Delete')),
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
