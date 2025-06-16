// lib/screens/master/customer_master_screen.dart

import 'package:flutter/material.dart';
import '../../models/customer.dart';
import '../../services/api.dart';
import '../../widgets/generic_data_table.dart';
import '../../widgets/table_column.dart';

class CustomerMasterScreen extends StatefulWidget {
  const CustomerMasterScreen({super.key});

  @override
  State<CustomerMasterScreen> createState() => _CustomerMasterScreenState();
}

class _CustomerMasterScreenState extends State<CustomerMasterScreen> {
  List<Customer> _customers = [];
  List<Customer> _all = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _loading = true);
    try {
      final data = await ApiService.fetchCustomers();
      setState(() {
        _all = data;
        _customers = data;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
    }
  }

  void _onFilter(String field, String q) {
    setState(() {
      _customers = _all.where((c) {
        final val = c.toJson()[field]?.toString().toLowerCase() ?? '';
        return val.contains(q.toLowerCase());
      }).toList();
    });
  }

  void _onEdit({Customer? customer}) {
    final isNew = customer == null;
    final nameCtrl = TextEditingController(text: customer?.name ?? '');
    final phoneCtrl = TextEditingController(text: customer?.phone ?? '');
    final emailCtrl = TextEditingController(text: customer?.email ?? '');
    final gstCtrl = TextEditingController(text: customer?.gst ?? '');
    final addressCtrl = TextEditingController(text: customer?.address ?? '');
    String? state = customer?.state;

    final states = [
      "Andhra Pradesh", "Arunachal Pradesh", "Assam", "Bihar", "Chhattisgarh",
      "Goa", "Gujarat", "Haryana", "Himachal Pradesh", "Jharkhand", "Karnataka",
      "Kerala", "Madhya Pradesh", "Maharashtra", "Manipur", "Meghalaya",
      "Mizoram", "Nagaland", "Odisha", "Punjab", "Rajasthan", "Sikkim",
      "Tamil Nadu", "Telangana", "Tripura", "Uttar Pradesh", "Uttarakhand",
      "West Bengal", "Andaman and Nicobar Islands", "Chandigarh", "Dadra and Nagar Haveli",
      "Daman and Diu", "Delhi", "Jammu and Kashmir", "Ladakh", "Lakshadweep", "Puducherry"
    ];

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(isNew ? 'Add Customer' : 'Edit Customer'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Name')),
              TextField(controller: phoneCtrl, decoration: const InputDecoration(labelText: 'Phone')),
              TextField(controller: emailCtrl, decoration: const InputDecoration(labelText: 'Email')),
              TextField(controller: gstCtrl, decoration: const InputDecoration(labelText: 'GST')),
              TextField(controller: addressCtrl, decoration: const InputDecoration(labelText: 'Address')),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: state,
                items: states.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                decoration: const InputDecoration(labelText: 'State'),
                onChanged: (val) => state = val,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              final updated = Customer(
                id: customer?.id ?? 0, // 0 or any placeholder for new customer
                name: nameCtrl.text.trim(),
                phone: phoneCtrl.text.trim(),
                email: emailCtrl.text.trim(),
                gst: gstCtrl.text.trim(),
                address: addressCtrl.text.trim(),
                state: state,
              );

              try {
                if (customer == null) {
                  await ApiService.addCustomer(updated);
                } else {
                  await ApiService.updateCustomer(updated);
                }
                if (!mounted) return;
                Navigator.pop(context);
                _loadData();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Save failed: ${e.toString()}')),
                );
              }
            },

            child: const Text('Save'),
          ),

        ],
      ),
    );
  }

  void _onDelete(int id) async {
    await ApiService.deleteCustomer(id);
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customer Master')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : GenericDataTable<Customer>(
              columns: [
                TableColumn(title: 'ID', field: 'id', sortable: true, cellBuilder: (c) => Text('${c.id}')),
                TableColumn(title: 'Name', field: 'name', filterable: true),
                TableColumn(title: 'Phone', field: 'phone'),
                TableColumn(title: 'Email', field: 'email'),
                TableColumn(title: 'GST', field: 'gst'),
                TableColumn(title: 'Address', field: 'address'),
                TableColumn(title: 'State', field: 'state'),
                TableColumn(
                  title: 'Actions',
                  field: 'actions',
                  cellBuilder: (c) => PopupMenuButton<String>(
                    onSelected: (v) {
                      if (v == 'edit') _onEdit(customer: c);
                      if (v == 'delete') _onDelete(c.id);
                    },
                    itemBuilder: (_) => const [
                      PopupMenuItem(value: 'edit', child: Text('Edit')),
                      PopupMenuItem(value: 'delete', child: Text('Delete')),
                    ],
                  ),
                ),
              ],
              rows: _customers,
              onFilter: _onFilter,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onEdit(),  // For add
        child: const Icon(Icons.add),
      ),
    );
  }
}
