// lib/screens/restaurant/table_layout_screen.dart

import 'package:flutter/material.dart';
import '../../models/restaurant/table_layout.dart';
import '../../services/restaurant/table_layout_service.dart';
import '../../widgets/generic_data_table.dart';
import '../../widgets/table_column.dart';

class TableLayoutScreen extends StatefulWidget {
  const TableLayoutScreen({Key? key}) : super(key: key);

  @override
  State<TableLayoutScreen> createState() => _TableLayoutScreenState();
}

class _TableLayoutScreenState extends State<TableLayoutScreen> {
  List<TableLayout> _tables = [];
  List<TableLayout> _allTables = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadTables();
  }

  Future<void> _loadTables() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      _allTables = await TableLayoutService.fetchTableLayouts();
      _tables = List.of(_allTables);
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
      _tables.sort((a, b) {
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
      _tables = _allTables.where((t) {
        final val = t.toJson()[field]?.toString().toLowerCase() ?? '';
        return val.contains(query.toLowerCase());
      }).toList();
    });
  }

  void _showForm({TableLayout? table}) {
    final isEdit = table != null;
    final nameCtl = TextEditingController(text: table?.name ?? '');
    final typeCtl = TextEditingController(text: table?.type ?? '');
    final posXCtl = TextEditingController(text: table?.positionX.toString() ?? '');
    final posYCtl = TextEditingController(text: table?.positionY.toString() ?? '');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isEdit ? 'Edit Table' : 'Add Table'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: nameCtl, decoration: const InputDecoration(labelText: 'Name')),
              TextField(controller: typeCtl, decoration: const InputDecoration(labelText: 'Type')),
              TextField(
                controller: posXCtl,
                decoration: const InputDecoration(labelText: 'Position X'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: posYCtl,
                decoration: const InputDecoration(labelText: 'Position Y'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              final name = nameCtl.text.trim();
              final type = typeCtl.text.trim();
              final posX = int.tryParse(posXCtl.text.trim()) ?? 0;
              final posY = int.tryParse(posYCtl.text.trim()) ?? 0;

              if (name.isEmpty || type.isEmpty) return;

              final model = TableLayout(
                id: table?.id ?? '',
                name: name,
                type: type,
                positionX: posX,
                positionY: posY,
                isActive: true,
              );

              try {
                if (isEdit) {
                  await TableLayoutService.updateTable(model);
                } else {
                  await TableLayoutService.createTable(model);
                }
                Navigator.of(ctx).pop();
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

  void _deleteTable(String id) async {
    try {
      await TableLayoutService.deleteTable(id);
      await _loadTables();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Delete failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Table Layout')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Error: $_error'))
              : GenericDataTable<TableLayout>(
                  columns: [
                    TableColumn(title: 'Name', field: 'name', filterable: true),
                    TableColumn(title: 'Type', field: 'type'),
                    TableColumn(title: 'Pos X', field: 'positionX'),
                    TableColumn(title: 'Pos Y', field: 'positionY'),
                    TableColumn(
                      title: 'Actions',
                      field: 'actions',
                      cellBuilder: (t) => PopupMenuButton<String>(
                        onSelected: (v) {
                          if (v == 'edit') _showForm(table: t);
                          if (v == 'delete') _deleteTable(t.id);
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
