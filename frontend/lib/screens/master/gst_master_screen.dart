// lib/screens/master/gst_master_screen.dart

import 'package:flutter/material.dart';

class GSTMasterScreen extends StatefulWidget {
  const GSTMasterScreen({super.key});

  @override
  State<GSTMasterScreen> createState() => _GSTMasterScreenState();
}

class _GSTMasterScreenState extends State<GSTMasterScreen> {
  List<Map<String, dynamic>> gstSlabs = [
    {'name': 'GST 5%', 'rate': 5.0},
    {'name': 'GST 12%', 'rate': 12.0},
    {'name': 'GST 18%', 'rate': 18.0},
    {'name': 'GST 28%', 'rate': 28.0},
  ];

  void _showGstDialog({int? index}) {
    final isEdit = index != null;
    final nameController = TextEditingController(text: isEdit ? gstSlabs[index]['name'] : '');
    final rateController = TextEditingController(text: isEdit ? gstSlabs[index]['rate'].toString() : '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEdit ? 'Edit GST Slab' : 'Add GST Slab'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: rateController,
              decoration: const InputDecoration(labelText: 'Rate (%)'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final name = nameController.text.trim();
              final rate = double.tryParse(rateController.text.trim()) ?? 0.0;
              if (name.isEmpty || rate <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please enter valid name and rate')),
                );
                return;
              }

              setState(() {
                if (isEdit) {
                  gstSlabs[index!] = {'name': name, 'rate': rate};
                } else {
                  gstSlabs.add({'name': name, 'rate': rate});
                }
              });

              Navigator.pop(context);
            },
            child: const Text('Save'),
          )
        ],
      ),
    );
  }

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete GST Slab'),
        content: const Text('Are you sure you want to delete this GST slab?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                gstSlabs.removeAt(index);
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
      appBar: AppBar(title: const Text('GST Master')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showGstDialog(),
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
          columns: const [
            DataColumn(label: Text('No.', style: headerStyle)),
            DataColumn(label: Text('Name', style: headerStyle)),
            DataColumn(label: Text('Rate (%)', style: headerStyle)),
            DataColumn(label: Text('Actions', style: headerStyle)),
          ],
          rows: List.generate(gstSlabs.length, (index) {
            final slab = gstSlabs[index];
            return DataRow(
              cells: [
                DataCell(Text('${index + 1}')),
                DataCell(Text(slab['name'])),
                DataCell(Text(slab['rate'].toString())),
                DataCell(
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        _showGstDialog(index: index);
                      } else if (value == 'delete') {
                        _confirmDelete(index);
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
