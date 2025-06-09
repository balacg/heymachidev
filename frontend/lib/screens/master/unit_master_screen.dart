import 'package:flutter/material.dart';

class UnitMasterScreen extends StatefulWidget {
  const UnitMasterScreen({super.key});

  @override
  State<UnitMasterScreen> createState() => _UnitMasterScreenState();
}

class _UnitMasterScreenState extends State<UnitMasterScreen> {
  List<String> units = ['Kg', 'Litre', 'Piece'];

  void _showUnitDialog({int? index}) {
    final isEdit = index != null;
    final unitController = TextEditingController(text: isEdit ? units[index] : '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEdit ? 'Edit Unit' : 'Add Unit'),
          content: TextField(controller: unitController, decoration: const InputDecoration(labelText: 'Unit')),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (isEdit) {
                    units[index!] = unitController.text;
                  } else {
                    units.add(unitController.text);
                  }
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            )
          ],
        );
      },
    );
  }

  void _deleteUnit(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Unit'),
        content: const Text('Are you sure you want to delete this unit?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                units.removeAt(index);
              });
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
    const headerStyle = TextStyle(fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBar(title: const Text('Unit Master')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showUnitDialog(),
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
          columns: const [
            DataColumn(label: Text('No.', style: headerStyle)),
            DataColumn(label: Text('Unit', style: headerStyle)),
            DataColumn(label: Text('Actions', style: headerStyle)),
          ],
          rows: List.generate(units.length, (index) {
            final unit = units[index];
            return DataRow(
              cells: [
                DataCell(Text('${index + 1}')),
                DataCell(Text(unit)),
                DataCell(
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        _showUnitDialog(index: index);
                      } else if (value == 'delete') {
                        _deleteUnit(index);
                      }
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(value: 'edit', child: Text('Edit')),
                      PopupMenuItem(value: 'delete', child: Text('Delete')),
                    ],
                    icon: const Icon(Icons.more_vert),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
