// lib/widgets/generic_data_table.dart

import 'package:flutter/material.dart';
import 'table_column.dart';

typedef SortCallback = void Function(String field, bool ascending);
typedef FilterCallback = void Function(String field, String query);

class GenericDataTable<T> extends StatefulWidget {
  final List<TableColumn<T>> columns;
  final List<T> rows;
  final SortCallback? onSort;
  final FilterCallback? onFilter;
  final int rowsPerPage;

  const GenericDataTable({
    Key? key,
    required this.columns,
    required this.rows,
    this.onSort,
    this.onFilter,
    this.rowsPerPage = PaginatedDataTable.defaultRowsPerPage,
  }) : super(key: key);

  @override
  _GenericDataTableState<T> createState() => _GenericDataTableState<T>();
}

class _GenericDataTableState<T> extends State<GenericDataTable<T>> {
  int _sortColumnIndex = 0;
  bool _sortAscending = true;
  late List<TableColumn<T>> _cols;

  @override
  void initState() {
    super.initState();
    _cols = widget.columns;
  }

  /// Gracefully retrieve a field from map or object
  dynamic _getValue(T row, String field) {
    try {
      return (row as dynamic)[field];
    } catch (_) {
      try {
        return (row as dynamic).toJson()[field];
      } catch (_) {
        return '';
      }
    }
  }

  void _handleSort(int idx, bool asc) {
    setState(() {
      _sortColumnIndex = idx;
      _sortAscending = asc;
    });
    final col = _visibleColumns()[idx];
    widget.onSort?.call(col.field, asc);
  }

  void _showFilterDialog(TableColumn<T> col) {
    final ctrl = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Filter ${col.title}'),
        content: TextField(
          controller: ctrl,
          decoration: const InputDecoration(hintText: 'Enter filter…'),
          onSubmitted: (v) {
            widget.onFilter?.call(col.field, v);
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              widget.onFilter?.call(col.field, ctrl.text);
              Navigator.pop(context);
            },
            child: const Text('Apply'),
          )
        ],
      ),
    );
  }

  void _toggleVisibility(TableColumn<T> col) {
    setState(() {
      col.hidden = !col.hidden;
    });
  }

  List<TableColumn<T>> _visibleColumns() {
    final frozen = _cols.where((c) => c.frozen && !c.hidden).toList();
    final normal = _cols.where((c) => !c.frozen && !c.hidden).toList();
    return [...frozen, ...normal];
  }

  @override
  Widget build(BuildContext context) {
    final visibleCols = _visibleColumns();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: PopupMenuButton<TableColumn<T>>(
            icon: const Icon(Icons.view_column),
            itemBuilder: (_) => _cols
                .map((c) => CheckedPopupMenuItem<TableColumn<T>>(
                      value: c,
                      checked: !c.hidden,
                      child: Text(c.title),
                    ))
                .toList(),
            onSelected: _toggleVisibility,
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                sortColumnIndex: _sortColumnIndex,
                sortAscending: _sortAscending,
                columns: List.generate(visibleCols.length, (i) {
                  final col = visibleCols[i];
                  return DataColumn(
                    label: Row(
                      children: [
                        Text(col.title),
                        if (col.filterable)
                          IconButton(
                            icon: const Icon(Icons.filter_list, size: 16),
                            onPressed: () => _showFilterDialog(col),
                          ),
                      ],
                    ),
                    onSort: col.sortable ? (index, asc) => _handleSort(i, asc) : null,
                  );
                }),
                rows: widget.rows.map((row) {
                  return DataRow(
                    cells: visibleCols.map((col) {
                      final value = _getValue(row, col.field);
                      final cellWidget = col.cellBuilder != null
                          ? col.cellBuilder!(row)
                          : Text('$value');
                      return DataCell(cellWidget);
                    }).toList(),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
