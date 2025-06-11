// lib/screens/master/gst_master_screen.dart

import 'package:flutter/material.dart';
import '../../widgets/table_column.dart';
import '../../widgets/generic_data_table.dart';

class GSTMasterScreen extends StatefulWidget {
  const GSTMasterScreen({Key? key}) : super(key: key);

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
  late List<Map<String, dynamic>> allSlabs;

  @override
  void initState() {
    super.initState();
    allSlabs = List.from(gstSlabs);
  }

  void _showGstDialog({int? index}) {
    final isEdit = index != null;
    final nameController =
        TextEditingController(text: isEdit ? gstSlabs[index!]['name'] : '');
    final rateController = TextEditingController(
        text: isEdit ? gstSlabs[index]['rate'].toString() : '');

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
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final name = nameController.text.trim();
              final rate = double.tryParse(rateController.text.trim()) ?? 0.0;
              if (name.isEmpty || rate <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Please enter valid name and rate')),
                );
                return;
              }
              setState(() {
                if (isEdit) {
                  gstSlabs[index!] = {'name': name, 'rate': rate};
                } else {
                  gstSlabs.add({'name': name, 'rate': rate});
                }
                allSlabs = List.from(gstSlabs);
              });
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
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
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                gstSlabs.removeAt(index);
                allSlabs = List.from(gstSlabs);
              });
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _onSort(String field, bool asc) {
    setState(() {
      gstSlabs.sort((a, b) {
        final va = a[field];
        final vb = b[field];
        if (va is Comparable && vb is Comparable) {
          return asc ? va.compareTo(vb) : vb.compareTo(va);
        }
        return 0;
      });
    });
  }

  void _onFilter(String field, String query) {
    setState(() {
      gstSlabs = allSlabs
          .where((slab) =>
              '${slab[field]}'.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GST Master')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showGstDialog(),
        child: const Icon(Icons.add),
      ),
      body: GenericDataTable<Map<String, dynamic>>(
        columns: [
          TableColumn<Map<String, dynamic>>(
            title: 'No.',
            field: 'no',
            frozen: true,
            cellBuilder: (slab) =>
                Text('${gstSlabs.indexOf(slab) + 1}'),
          ),
          TableColumn<Map<String, dynamic>>(
            title: 'Name',
            field: 'name',
            sortable: true,
            filterable: true,
            cellBuilder: (slab) => Text('${slab['name']}'),
          ),
          TableColumn<Map<String, dynamic>>(
            title: 'Rate (%)',
            field: 'rate',
            sortable: true,
            cellBuilder: (slab) => Text('${slab['rate']}'),
          ),
          TableColumn<Map<String, dynamic>>(
            title: 'Actions',
            field: 'actions',
            cellBuilder: (slab) {
              final idx = gstSlabs.indexOf(slab);
              return PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                onSelected: (v) {
                  if (v == 'edit') {
                    _showGstDialog(index: idx);
                  } else if (v == 'delete') {
                    _confirmDelete(idx);
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
        rows: gstSlabs,
        onSort: _onSort,
        onFilter: _onFilter,
      ),
    );
  }
}
