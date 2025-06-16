// lib/screens/master/vendor_master_screen.dart

import 'package:flutter/material.dart';
import '../../widgets/table_column.dart';
import '../../widgets/generic_data_table.dart';
import '../../services/api.dart';
import '../../models/vendor.dart';

class VendorMasterScreen extends StatefulWidget {
  const VendorMasterScreen({Key? key}) : super(key: key);

  @override
  State<VendorMasterScreen> createState() => _VendorMasterScreenState();
}

class _VendorMasterScreenState extends State<VendorMasterScreen> {
  List<Map<String, String>> _vendors = [
    {
      'company': 'Ravi & Co',
      'phone': '9876543210',
      'email': 'ravi@example.com',
      'gst': '',
    },
    // ... other initial vendors
  ];
  List<Map<String, String>> _allVendors = [];

  @override
void initState() {
  super.initState();
  fetchData();
}

void fetchData() async {
  try {
    final data = await ApiService.fetchVendors();
    setState(() {
      _vendors = data
          .map((v) => {
                'id': v.id.toString(),
                'company': v.name,
                'phone': v.phone,
                'email': v.email ?? '',
                'gst': v.gst ?? '',
                'address': v.address ?? '',
              })
          .toList();
    });
    _allVendors = List.from(_vendors);
  } catch (e) {
    print("Error loading vendors: $e");
  }
}


  void _showVendorDialog({int? index}) {
    final isEdit = index != null;
    final vendor = isEdit ? _vendors[index] : {};

    final nameCtrl = TextEditingController(text: vendor['company'] ?? '');
    final phoneCtrl = TextEditingController(text: vendor['phone'] ?? '');
    final emailCtrl = TextEditingController(text: vendor['email'] ?? '');
    final gstCtrl = TextEditingController(text: vendor['gst'] ?? '');
    final addrCtrl = TextEditingController(text: vendor['address'] ?? '');

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(isEdit ? 'Edit Vendor' : 'Add Vendor'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: nameCtrl, decoration: InputDecoration(labelText: 'Name')),
                TextField(controller: phoneCtrl, decoration: InputDecoration(labelText: 'Phone')),
                TextField(controller: emailCtrl, decoration: InputDecoration(labelText: 'Email')),
                TextField(controller: gstCtrl, decoration: InputDecoration(labelText: 'GST')),
                TextField(controller: addrCtrl, decoration: InputDecoration(labelText: 'Address')),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () async {
                final payload = Vendor(
                  id: isEdit ? int.parse(vendor['id']!) : null,
                  name: nameCtrl.text.trim(),
                  phone: phoneCtrl.text.trim(),
                  email: emailCtrl.text.trim().isEmpty ? null : emailCtrl.text.trim(),
                  gst: gstCtrl.text.trim().isEmpty ? null : gstCtrl.text.trim(),
                  address: addrCtrl.text.trim().isEmpty ? null : addrCtrl.text.trim(),
                );

                try {
                  if (isEdit) {
                    await ApiService.updateVendor(payload);
                  } else {
                    await ApiService.createVendor(payload);
                  }
                  fetchData();
                  Navigator.pop(context);
                } catch (e) {
                  print("Error saving vendor: $e");
                }
              },
              child: Text(isEdit ? 'Save' : 'Add'),
            ),
          ],
        );
      },
    );
  }



  void _deleteVendor(int index) async {
    try {
      final id = int.parse(_vendors[index]['id']!);
      await ApiService.deleteVendor(id);
      fetchData();
    } catch (e) {
      print("Error deleting vendor: $e");
    }
  }


  void _onSort(String field, bool asc) {
    setState(() {
      _vendors.sort((a, b) {
        final va = a[field]!;
        final vb = b[field]!;
        return asc ? va.compareTo(vb) : vb.compareTo(va);
      });
    });
  }

  void _onFilter(String field, String query) {
    setState(() {
      _vendors = _allVendors
          .where((v) =>
              v[field]!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vendor Master')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showVendorDialog(),
        child: const Icon(Icons.add),
      ),
      body: GenericDataTable<Map<String, String>>(
        columns: [
          TableColumn<Map<String, String>>(
            title: 'No.',
            field: 'no',
            cellBuilder: (v) => Text('${_vendors.indexOf(v) + 1}'),
            frozen: true,
          ),
          TableColumn<Map<String, String>>(
            title: 'Company',
            field: 'company',
            sortable: true,
            filterable: true,
          ),
          TableColumn<Map<String, String>>(
            title: 'Phone',
            field: 'phone',
            sortable: true,
            filterable: true,
          ),
          TableColumn<Map<String, String>>(
            title: 'Email',
            field: 'email',
            sortable: true,
            filterable: true,
          ),
          TableColumn<Map<String, String>>(
            title: 'GST Number',
            field: 'gst',
            sortable: true,
            filterable: true,
          ),
          TableColumn<Map<String, String>>(
            title: 'Actions',
            field: 'actions',
            cellBuilder: (v) => PopupMenuButton<String>(
              onSelected: (value) {
                final idx = _vendors.indexOf(v);
                if (value == 'edit') {
                  _showVendorDialog(index: idx);
                } else if (value == 'delete') {
                  _deleteVendor(idx);
                }
              },
              itemBuilder: (_) => const [
                PopupMenuItem(value: 'edit', child: Text('Edit')),
                PopupMenuItem(value: 'delete', child: Text('Delete')),
              ],
            ),
          ),
        ],
        rows: _vendors,
        onSort: _onSort,
        onFilter: _onFilter,
      ),
    );
  }
}
