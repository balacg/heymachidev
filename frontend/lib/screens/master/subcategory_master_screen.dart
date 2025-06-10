// lib/screens/master/subcategory_master_screen.dart

import 'package:flutter/material.dart';
import '../../services/api.dart';
import '../../models/subcategory.dart';

class SubcategoryMasterScreen extends StatefulWidget {
  const SubcategoryMasterScreen({super.key});

  @override
  State<SubcategoryMasterScreen> createState() => _SubcategoryMasterScreenState();
}

class _SubcategoryMasterScreenState extends State<SubcategoryMasterScreen> {
  List<Subcategory> _subcats = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadSubcategories();
  }

  Future<void> _loadSubcategories() async {
    try {
      final list = await ApiService.fetchSubcategories();
      setState(() {
        _subcats = list;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  void _showForm({Subcategory? subcat}) {
    final isEdit = subcat != null;
    final nameCtrl = TextEditingController(text: subcat?.name ?? '');
    final categoryCtrl = TextEditingController(text: subcat?.categoryId.toString() ?? '');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isEdit ? 'Edit Subcategory' : 'Add Subcategory'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Name')),
            TextField(controller: categoryCtrl, decoration: const InputDecoration(labelText: 'Category ID'), keyboardType: TextInputType.number),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              final id = subcat?.id ?? 0;
              final name = nameCtrl.text;
              final catId = int.tryParse(categoryCtrl.text) ?? 0;
              final model = Subcategory(id: id, name: name, categoryId: catId);
              if (isEdit) {
                await ApiService.updateSubcategory(model);
              } else {
                await ApiService.createSubcategory(model);
              }
              Navigator.pop(ctx);
              _loadSubcategories();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deleteSubcategory(int id) async {
    await ApiService.deleteSubcategory(id);
    _loadSubcategories();
  }

  @override
  Widget build(BuildContext context) {
    const headerStyle = TextStyle(fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBar(title: const Text('Subcategory Master')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Error: $_error'))
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
                    columns: const [
                      DataColumn(label: Text('No.', style: headerStyle)),
                      DataColumn(label: Text('ID', style: headerStyle)),
                      DataColumn(label: Text('Name', style: headerStyle)),
                      DataColumn(label: Text('Category ID', style: headerStyle)),
                      DataColumn(label: Text('Actions', style: headerStyle)),
                    ],
                    rows: List<DataRow>.generate(_subcats.length, (i) {
                      final s = _subcats[i];
                      return DataRow(cells: [
                        DataCell(Text('${i + 1}')),
                        DataCell(Text('${s.id}')),
                        DataCell(Text(s.name)),
                        DataCell(Text('${s.categoryId}')),
                        DataCell(PopupMenuButton<String>(
                          onSelected: (v) {
                            if (v == 'edit') _showForm(subcat: s);
                            else if (v == 'delete') _deleteSubcategory(s.id);
                          },
                          itemBuilder: (_) => const [
                            PopupMenuItem(value: 'edit', child: Text('Edit')),
                            PopupMenuItem(value: 'delete', child: Text('Delete')),
                          ],
                        )),
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
