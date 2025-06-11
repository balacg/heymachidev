// lib/screens/master/subcategory_master_screen.dart

import 'package:flutter/material.dart';
import '../../services/api.dart';
import '../../models/subcategory.dart';
import '../../models/category.dart';
import '../../models/tax.dart';
import '../../widgets/table_column.dart';
import '../../widgets/generic_data_table.dart';

class SubcategoryMasterScreen extends StatefulWidget {
  const SubcategoryMasterScreen({Key? key}) : super(key: key);

  @override
  State<SubcategoryMasterScreen> createState() =>
      _SubcategoryMasterScreenState();
}

class _SubcategoryMasterScreenState extends State<SubcategoryMasterScreen> {
  List<Subcategory> _subcats = [];
  List<Subcategory> _allSubcats = [];
  List<Category> _categories = [];
  List<Tax> _taxes = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadDeps();
  }

  Future<void> _loadDeps() async {
    setState(() => _loading = true);
    try {
      _categories = await ApiService.fetchCategories();
      _taxes = await ApiService.fetchTaxes();
      _allSubcats = await ApiService.fetchSubcategories();
      _subcats = _allSubcats;
    } catch (e) {
      _error = e.toString();
    } finally {
      setState(() => _loading = false);
    }
  }

  void _onSort(String field, bool asc) {
    setState(() {
      _subcats.sort((a, b) {
        final va = (a as dynamic)[field];
        final vb = (b as dynamic)[field];
        if (va is Comparable && vb is Comparable) {
          return asc ? va.compareTo(vb) : vb.compareTo(va);
        }
        return 0;
      });
    });
  }

  void _onFilter(String field, String query) {
    setState(() {
      _subcats = _allSubcats
          .where((s) =>
              '${(s as dynamic)[field]}'.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _showForm({Subcategory? subcategory}) {
    final isEdit = subcategory != null;
    final nameCtrl = TextEditingController(text: subcategory?.name ?? '');
    Category? selectedCat = isEdit
        ? _categories.firstWhere((c) => c.id == subcategory!.categoryId)
        : null;
    Tax? selectedTax = isEdit
        ? _taxes.firstWhere((t) => t.id == subcategory!.gstId)
        : null;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isEdit ? 'Edit Subcategory' : 'Add Subcategory'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<Category>(
              decoration: const InputDecoration(labelText: 'Category'),
              value: selectedCat,
              items: _categories
                  .map((c) => DropdownMenuItem(value: c, child: Text(c.name)))
                  .toList(),
              onChanged: (c) => selectedCat = c,
            ),
            const SizedBox(height: 8),
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
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              if (nameCtrl.text.trim().isEmpty ||
                  selectedCat == null ||
                  selectedTax == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please fill all fields')),
                );
                return;
              }
              final model = Subcategory(
                id: subcategory?.id ?? 0,
                name: nameCtrl.text.trim(),
                categoryId: selectedCat!.id,
                gstId: selectedTax!.id,
              );
              try {
                if (isEdit) {
                  await ApiService.updateSubcategory(model);
                } else {
                  await ApiService.createSubcategory(model);
                }
                Navigator.of(ctx).pop();
                
              } catch (e) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Error: $e')));
              }
              _loadDeps();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deleteSubcategory(int id) async {
    try {
      await ApiService.deleteSubcategory(id);
      _loadDeps();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Delete failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Subcategory Master')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Error: $_error'))
              : GenericDataTable<Subcategory>(
                  columns: [
                    TableColumn<Subcategory>(
                      title: 'ID',
                      field: 'id',
                      sortable: true,
                      frozen: true,
                      cellBuilder: (s) => Text('${s.id}'),
                    ),
                    TableColumn<Subcategory>(
                      title: 'Name',
                      field: 'name',
                      sortable: true,
                      filterable: true,
                    ),
                    TableColumn<Subcategory>(
                      title: 'Category',
                      field: 'categoryId',
                      cellBuilder: (s) {
                        final c = _categories.firstWhere((c) => c.id == s.categoryId);
                        return Text(c.name);
                      },
                      sortable: false,
                    ),
                    TableColumn<Subcategory>(
                      title: 'GST %',
                      field: 'gstId',
                      cellBuilder: (s) {
                        final t = _taxes.firstWhere((t) => t.id == s.gstId);
                        return Text('${t.rate.toStringAsFixed(2)}%');
                      },
                      sortable: false,
                    ),
                    TableColumn<Subcategory>(
                      title: 'Actions',
                      field: 'actions',
                      cellBuilder: (s) => PopupMenuButton<String>(
                        onSelected: (v) {
                          if (v == 'edit') _showForm(subcategory: s);
                          else if (v == 'delete') _deleteSubcategory(s.id);
                        },
                        itemBuilder: (_) => const [
                          PopupMenuItem(value: 'edit', child: Text('Edit')),
                          PopupMenuItem(value: 'delete', child: Text('Delete')),
                        ],
                      ),
                    ),
                  ],
                  rows: _subcats,
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
