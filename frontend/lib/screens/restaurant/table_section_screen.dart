// lib/screens/restaurant/table_section_screen.dart

import 'package:flutter/material.dart';
import '../../models/restaurant/table_section.dart';
import '../../services/restaurant/table_section_service.dart';
import '../../widgets/generic_data_table.dart';
import '../../widgets/table_column.dart';

class TableSectionScreen extends StatefulWidget {
  const TableSectionScreen({Key? key}) : super(key: key);

  @override
  State<TableSectionScreen> createState() => _TableSectionScreenState();
}

class _TableSectionScreenState extends State<TableSectionScreen> {
  List<TableSection> _sections = [];
  List<TableSection> _allSections = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadSections();
  }

  Future<void> _loadSections() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      _allSections = await TableSectionService.fetchSections();
      _sections = List.of(_allSections);
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
      _sections.sort((a, b) {
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
      _sections = _allSections.where((s) {
        final val = s.toJson()[field]?.toString().toLowerCase() ?? '';
        return val.contains(query.toLowerCase());
      }).toList();
    });
  }

  void _showForm({TableSection? section}) {
    final isEdit = section != null;
    final nameCtl = TextEditingController(text: section?.name ?? '');
    final descCtl = TextEditingController(text: section?.description ?? '');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isEdit ? 'Edit Section' : 'Add Section'),
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

              final model = TableSection(
                id: section?.id ?? '',
                name: name,
                description: desc,
                isActive: true,
              );

              try {
                if (isEdit) {
                  await TableSectionService.updateSection(model);
                } else {
                  await TableSectionService.createSection(model);
                }
                Navigator.of(ctx).pop();
                await _loadSections();
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

  void _deleteSection(String id) async {
    try {
      await TableSectionService.deleteSection(id);
      await _loadSections();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Delete failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Table Sections')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Error: $_error'))
              : GenericDataTable<TableSection>(
                  columns: [
                    TableColumn(title: 'Name', field: 'name', filterable: true),
                    TableColumn(title: 'Description', field: 'description'),
                    TableColumn(
                      title: 'Actions',
                      field: 'actions',
                      cellBuilder: (s) => PopupMenuButton<String>(
                        onSelected: (v) {
                          if (v == 'edit') _showForm(section: s);
                          if (v == 'delete') _deleteSection(s.id);
                        },
                        itemBuilder: (_) => const [
                          PopupMenuItem(value: 'edit', child: Text('Edit')),
                          PopupMenuItem(value: 'delete', child: Text('Delete')),
                        ],
                      ),
                    ),
                  ],
                  rows: _sections,
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
