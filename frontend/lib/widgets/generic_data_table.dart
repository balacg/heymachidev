// lib/widgets/generic_data_table.dart

import 'package:flutter/material.dart';
import 'table_column.dart';

typedef SortCallback = void Function(String field, bool ascending);
typedef FilterCallback = void Function(String field, String query);
typedef VoidCallback = void Function();
typedef SearchCallback = void Function(String query);

class GenericDataTable<T> extends StatefulWidget {
  final List<TableColumn<T>> columns;
  final List<T> rows;
  final SortCallback? onSort;
  final FilterCallback? onFilter;
  final SearchCallback? onSearch;
  final VoidCallback? onExportCsv;
  final VoidCallback? onExportPdf;
  final String? searchHint;
  final int rowsPerPage;

  const GenericDataTable({
    Key? key,
    required this.columns,
    required this.rows,
    this.onSort,
    this.onFilter,
    this.onSearch,
    this.onExportCsv,
    this.onExportPdf,
    this.searchHint,
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
    setState(() => col.hidden = !col.hidden);
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
        // Top bar: Search + Column selector + More menu
        Row(
          children: [
            if (widget.onSearch != null)
              Expanded(
                child: TextField(
                  onChanged: widget.onSearch,
                  decoration: InputDecoration(
                    hintText: widget.searchHint ?? 'Search…',
                    prefixIcon: const Icon(Icons.search),
                    border: const OutlineInputBorder(),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  ),
                ),
              ),
            const SizedBox(width: 8),

            // Column Chooser
            PopupMenuButton<TableColumn<T>>(
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

            // Export menu
            if (widget.onExportCsv != null || widget.onExportPdf != null)
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                onSelected: (value) {
                  if (value == 'csv') widget.onExportCsv?.call();
                  if (value == 'pdf') widget.onExportPdf?.call();
                },
                itemBuilder: (_) => [
                  if (widget.onExportCsv != null)
                    const PopupMenuItem(value: 'csv', child: Text('Export CSV')),
                  if (widget.onExportPdf != null)
                    const PopupMenuItem(value: 'pdf', child: Text('Export PDF')),
                ],
              ),
          ],
        ),

        const SizedBox(height: 10),

        // Table content
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
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
                              icon: const Icon(Icons.filter_list, size: 16),
                              onPressed: () => _showFilterDialog(visibleCols[i]),
                            ),
                        ],
                      ),
                      onSort: visibleCols[i].sortable
                          ? (ci, asc) => _handleSort(i, asc)
                          : null,
                    ),
                ],
                rows: widget.rows.map((row) {
                  return DataRow(
                    cells: visibleCols.map((col) {
                      final cell = col.cellBuilder?.call(row) ??
                          Text('${_getValue(row, col.field)}');
                      return DataCell(cell);
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
