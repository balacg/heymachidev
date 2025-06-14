// lib/screens/restaurant/table_screen.dart

import 'package:flutter/material.dart';
import '../../models/restaurant/table.dart';
import '../../services/restaurant/table_service.dart';
import '../../widgets/generic_data_table.dart';
import '../../widgets/table_column.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({super.key});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  List<RestaurantTable> _tables = [];
  List<RestaurantTable> _allTables = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadTables();
  }

  Future<void> _loadTables() async {
    setState(() => _loading = true);
    try {
      _allTables = await TableService.fetchTables();
      _tables = List.of(_allTables);
    } catch (e) {
      _error = e.toString();
    } finally {
      setState(() => _loading = false);
    }
  }

  void _onSort(String field, bool asc) {
    setState(() {
      _tables.sort((a, b) {
        final va = (a.toJson())[field];
        final vb = (b.toJson())[field];
        if (va is Comparable && vb is Comparable) {
          return asc ? va.compareTo(vb) : vb.compareTo(va);
        }
        return 0;
      });
    });
  }

  void _onFilter(String field, String query) {
    setState(() {
      _tables = _allTables.where((t) {
        final val = (t.toJson())[field]?.toString().toLowerCase() ?? '';
        return val.contains(query.toLowerCase());
      }).toList();
    });
  }

  void _showForm({RestaurantTable? table}) {
    final isEdit = table != null;
    final nameCtl = TextEditingController(text: table?.name ?? '');
    final capCtl = TextEditingController(text: table?.capacity.toString() ?? '');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isEdit ? 'Edit Table' : 'Add Table'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtl, decoration: const InputDecoration(labelText: 'Table Name')),
            TextField(
              controller: capCtl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Capacity'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              final name = nameCtl.text.trim();
              final cap = int.tryParse(capCtl.text.trim()) ?? 0;

              if (name.isEmpty || cap <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Valid name & capacity required')));
                return;
              }

              final model = RestaurantTable(id: table?.id, name: name, capacity: cap);
              try {
                if (isEdit) {
                  await TableService.updateTable(model);
                } else {
                  await TableService.createTable(model);
                }
                Navigator.pop(ctx);
                await _loadTables();
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

  void _delete(String id) async {
    try {
      await TableService.deleteTable(id);
      await _loadTables();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Delete failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Restaurant Tables')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Error: $_error'))
              : GenericDataTable<RestaurantTable>(
                  columns: [
                    TableColumn(title: 'ID', field: 'id', cellBuilder: (t) => Text(t.id ?? '')),
                    TableColumn(title: 'Name', field: 'name', sortable: true, filterable: true),
                    TableColumn(title: 'Capacity', field: 'capacity', sortable: true),
                    TableColumn(
                      title: 'Actions',
                      field: 'actions',
                      cellBuilder: (t) => PopupMenuButton<String>(
                        onSelected: (v) {
                          if (v == 'edit') _showForm(table: t);
                          if (v == 'delete') _delete(t.id!);
                        },
                        itemBuilder: (_) => const [
                          PopupMenuItem(value: 'edit', child: Text('Edit')),
                          PopupMenuItem(value: 'delete', child: Text('Delete')),
                        ],
                      ),
                    ),
                  ],
                  rows: _tables,
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
