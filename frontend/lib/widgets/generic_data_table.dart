// lib/widgets/generic_data_table.dart

import 'package:flutter/material.dart';
import 'table_column.dart';

typedef SortCallback = void Function(String field, bool ascending);
typedef FilterCallback = void Function(String field, String query);

/// A reusable, feature-rich table widget supporting:
/// • sorting      (on sortable columns)
/// • filtering    (via header filter icon)
/// • freeze-cols  (frozen=true columns pinned left)
/// • hide/unhide  (via a column chooser)
/// • horizontal scroll
class GenericDataTable<T> extends StatefulWidget {
  /// List of all columns (including hidden ones).
  final List<TableColumn<T>> columns;

  /// All of your rows of data.
  final List<T> rows;

  /// Called when user sorts a column.
  final SortCallback? onSort;

  /// Called when user applies a filter.
  final FilterCallback? onFilter;

  /// How many rows per page if you switch to a PaginatedDataTable.
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
          decoration: InputDecoration(hintText: 'Enter filter…'),
          onSubmitted: (v) {
            widget.onFilter?.call(col.field, v);
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          TextButton(
            onPressed: () {
              widget.onFilter?.call(col.field, ctrl.text);
              Navigator.pop(context);
            },
            child: Text('Apply'),
          ),
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
    // Frozen ones first, then the rest, filtering out hidden.
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
        // Column-chooser button
        Align(
          alignment: Alignment.centerRight,
          child: PopupMenuButton<TableColumn<T>>(
            icon: Icon(Icons.view_column),
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

        // Actual table
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            sortColumnIndex: _sortColumnIndex,
            sortAscending: _sortAscending,
            columns: [
              for (int i = 0; i < visibleCols.length; i++)
                DataColumn(
                  label: Row(
                    children: [
                      Text(visibleCols[i].title),
                      if (visibleCols[i].filterable)
                        IconButton(
                          icon: Icon(Icons.filter_list, size: 16),
                          onPressed: () => _showFilterDialog(visibleCols[i]),
                        ),
                    ],
                  ),
                  onSort: visibleCols[i].sortable
                      ? (colIndex, asc) => _handleSort(i, asc)
                      : null,
                ),
            ],
            rows: widget.rows.map((row) {
              return DataRow(
                cells: visibleCols.map((col) {
                  final cell = col.cellBuilder?.call(row) ??
                      Text('${(row as dynamic)[col.field] ?? ''}');
                  return DataCell(cell);
                }).toList(),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
