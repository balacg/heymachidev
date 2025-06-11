// lib/screens/master/unit_master_screen.dart

import 'package:flutter/material.dart';
import '../../widgets/table_column.dart';
import '../../widgets/generic_data_table.dart';

class UnitMasterScreen extends StatefulWidget {
  const UnitMasterScreen({Key? key}) : super(key: key);

  @override
  State<UnitMasterScreen> createState() => _UnitMasterScreenState();
}

class _UnitMasterScreenState extends State<UnitMasterScreen> {
  List<String> _units = ['Kg', 'Litre', 'Piece'];
  List<String> _allUnits = [];

  @override
  void initState() {
    super.initState();
    _allUnits = List.from(_units);
  }

  void _showUnitDialog({int? index}) {
    // ← your existing add/edit dialog code
  }

  void _deleteUnit(int index) {
    setState(() {
      _units.removeAt(index);
      _allUnits = List.from(_units);
    });
  }

  void _onSort(String field, bool asc) {
    setState(() {
      _units.sort((a, b) => asc ? a.compareTo(b) : b.compareTo(a));
    });
  }

  void _onFilter(String field, String query) {
    setState(() {
      _units = _allUnits
          .where((u) => u.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Unit Master')),
      body: GenericDataTable<String>(
        columns: [
          TableColumn<String>(
            title: 'No.',
            field: 'no',
            cellBuilder: (u) => Text('${_units.indexOf(u) + 1}'),
            frozen: true,
          ),
          TableColumn<String>(
            title: 'Unit',
            field: 'unit',
            sortable: true,
            filterable: true,
            cellBuilder: (u) => Text(u),
          ),
          TableColumn<String>(
            title: 'Actions',
            field: 'actions',
            cellBuilder: (u) {
              final idx = _units.indexOf(u);
              return PopupMenuButton<String>(
                onSelected: (v) {
                  if (v == 'edit') {
                    _showUnitDialog(index: idx);
                  } else if (v == 'delete') {
                    _deleteUnit(idx);
                  }
                },
                itemBuilder: (_) => const [
                  PopupMenuItem(value: 'edit', child: Text('Edit')),
                  PopupMenuItem(value: 'delete', child: Text('Delete')),
                ],
              );
            },
          ),
        ],
        rows: _units,
        onSort: _onSort,
        onFilter: _onFilter,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showUnitDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
