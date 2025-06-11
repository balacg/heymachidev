// lib/screens/master/vendor_master_screen.dart

import 'package:flutter/material.dart';
import '../../widgets/table_column.dart';
import '../../widgets/generic_data_table.dart';

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
    _allVendors = List.from(_vendors);
  }

  void _showVendorDialog({int? index}) {
    // ← your existing add/edit dialog code
  }

  void _deleteVendor(int index) {
    setState(() {
      _vendors.removeAt(index);
      _allVendors = List.from(_vendors);
    });
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
