// lib/widgets/standard_data_table.dart

import 'package:flutter/material.dart';

typedef OnEditCallback = void Function(int index, List<String> row);
typedef OnDeleteCallback = void Function(int index);
typedef OnAddCallback = void Function(List<String> newRow);

class StandardDataTable extends StatefulWidget {
  final List<String> columns; // excludes sticky col header
  final List<List<String>> rows;
  final OnEditCallback? onEdit;
  final OnDeleteCallback? onDelete;
  final OnAddCallback? onAdd;

  const StandardDataTable({
    super.key,
    required this.columns,
    required this.rows,
    this.onEdit,
    this.onDelete,
    this.onAdd,
  });

  @override
  _StandardDataTableState createState() => _StandardDataTableState();
}

class _StandardDataTableState extends State<StandardDataTable> {
  late List<List<String>> _rows;

  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _rows = List.from(widget.rows);
  }

  void _showEditDialog(int index) {
    final row = List<String>.from(_rows[index]);
    showDialog(
      context: context,
      builder: (context) {
        List<TextEditingController> controllers =
            row.map((cell) => TextEditingController(text: cell)).toList();
        return AlertDialog(
          title: const Text('Edit Row'),
          content: SingleChildScrollView(
            child: Column(
              children: List.generate(widget.columns.length, (i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: TextField(
                    controller: controllers[i],
                    decoration: InputDecoration(labelText: widget.columns[i]),
                  ),
                );
              }),
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                final updatedRow = controllers.map((c) => c.text).toList();
                setState(() {
                  _rows[index] = updatedRow;
                });
                widget.onEdit?.call(index, updatedRow);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            )
          ],
        );
      },
    );
  }

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this row?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _rows.removeAt(index);
              });
              widget.onDelete?.call(index);
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      controller: _verticalScrollController,
      child: SingleChildScrollView(
        controller: _verticalScrollController,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sticky left "No." column
            SizedBox(
              width: 50,
              child: Column(
                children: [
                  Container(
                    height: 50,
                    color: Colors.indigo.withOpacity(0.1),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(12),
                    child: const Text(
                      'No.',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ...List.generate(
                    _rows.length,
                    (index) => Container(
                      height: 52,
                      padding: const EdgeInsets.all(12),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                      child: Text('${index + 1}'),
                    ),
                  ),
                ],
              ),
            ),

            // Horizontally scrollable columns + actions
            Expanded(
              child: Scrollbar(
                thumbVisibility: true,
                controller: _horizontalScrollController,
                child: SingleChildScrollView(
                  controller: _horizontalScrollController,
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header row
                      Row(
                        children: [
                          ...widget.columns
                              .map(
                                (col) => Container(
                                  width: 120,
                                  height: 50,
                                  padding: const EdgeInsets.all(12),
                                  alignment: Alignment.centerLeft,
                                  color: Colors.indigo.withOpacity(0.1),
                                  child: Text(
                                    col,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                              .toList(),
                          Container(
                            width: 80,
                            height: 50,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(12),
                            color: Colors.indigo.withOpacity(0.1),
                            child: const Text(
                              'Actions',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),

                      // Data rows
                      ...List.generate(_rows.length, (index) {
                        final row = _rows[index];
                        return Row(
                          children: [
                            ...row.map(
                              (cell) => Container(
                                width: 120,
                                height: 52,
                                padding: const EdgeInsets.all(12),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: Colors.grey.shade300),
                                  ),
                                ),
                                child: Text(cell),
                              ),
                            ),
                            Container(
                              width: 80,
                              height: 52,
                              alignment: Alignment.center,
                              child: PopupMenuButton<String>(
                                onSelected: (value) {
                                  if (value == 'edit') {
                                    _showEditDialog(index);
                                  } else if (value == 'delete') {
                                    _confirmDelete(index);
                                  }
                                },
                                itemBuilder: (context) => const [
                                  PopupMenuItem(value: 'edit', child: Text('Edit')),
                                  PopupMenuItem(value: 'delete', child: Text('Delete')),
                                ],
                                child: const Icon(Icons.more_vert),
                              ),
                            )
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
