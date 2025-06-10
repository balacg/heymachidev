// lib/screens/master/customer_master_screen.dart

import 'package:flutter/material.dart';
import '../../services/api.dart';
import '../../models/customer.dart';

class CustomerMasterScreen extends StatefulWidget {
  const CustomerMasterScreen({Key? key}) : super(key: key);

  @override
  State<CustomerMasterScreen> createState() => _CustomerMasterScreenState();
}

class _CustomerMasterScreenState extends State<CustomerMasterScreen> {
  List<Customer> _customers = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadCustomers();
  }

  Future<void> _loadCustomers() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      _customers = await ApiService.fetchCustomers();
    } catch (e) {
      _error = e.toString();
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _deleteCustomer(int id) async {
    await ApiService.deleteCustomer(id);
    _loadCustomers();
  }

  void _showForm({Customer? customer}) {
    final isEdit = customer != null;
    final nameCtrl    = TextEditingController(text: customer?.name ?? '');
    final phoneCtrl   = TextEditingController(text: customer?.phone ?? '');
    final emailCtrl   = TextEditingController(text: customer?.email ?? '');
    final gstCtrl     = TextEditingController(text: customer?.gst ?? '');
    final addressCtrl = TextEditingController(text: customer?.address ?? '');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isEdit ? 'Edit Customer' : 'Add Customer'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameCtrl,    decoration: const InputDecoration(labelText: 'Name')),
              TextField(controller: phoneCtrl,   decoration: const InputDecoration(labelText: 'Phone')),
              TextField(controller: emailCtrl,   decoration: const InputDecoration(labelText: 'Email')),
              TextField(controller: gstCtrl,     decoration: const InputDecoration(labelText: 'GST Number')),
              TextField(controller: addressCtrl, decoration: const InputDecoration(labelText: 'Address')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              final model = Customer(
                id:      customer?.id ?? 0,
                name:    nameCtrl.text,
                phone:  phoneCtrl.text,
                email:   emailCtrl.text,
                gst:     gstCtrl.text,
                address: addressCtrl.text,
              );
              Navigator.of(ctx).pop();
              if (isEdit) {
                await ApiService.updateCustomer(model);
              } else {
                await ApiService.addCustomer(model);
              }
              _loadCustomers();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const headerStyle = TextStyle(fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBar(title: const Text('Customer Master')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Error: $_error'))
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
                    columns: const [
                      DataColumn(label: Text('No.',        style: headerStyle)),
                      DataColumn(label: Text('ID',         style: headerStyle)),
                      DataColumn(label: Text('Name',       style: headerStyle)),
                      DataColumn(label: Text('Phone',      style: headerStyle)),
                      DataColumn(label: Text('Email',      style: headerStyle)),
                      DataColumn(label: Text('GST No.',    style: headerStyle)),
                      DataColumn(label: Text('Address',    style: headerStyle)),
                      DataColumn(label: Text('Actions',    style: headerStyle)),
                    ],
                    rows: List<DataRow>.generate(_customers.length, (i) {
                      final c = _customers[i];
                      return DataRow(cells: [
                        DataCell(Text('${i + 1}')),
                        DataCell(Text('${c.id}')),
                        DataCell(Text(c.name)),
                        DataCell(Text(c.phone)),
                        DataCell(Text(c.email)),
                        DataCell(Text(c.gst.isEmpty ? '-' : c.gst)),
                        DataCell(Text(c.address.isEmpty ? '-' : c.address)),
                        DataCell(
                          PopupMenuButton<String>(
                            onSelected: (v) {
                              if (v == 'edit') _showForm(customer: c);
                              else if (v == 'delete') _deleteCustomer(c.id);
                            },
                            itemBuilder: (_) => const [
                              PopupMenuItem(value: 'edit',   child: Text('Edit')),
                              PopupMenuItem(value: 'delete', child: Text('Delete')),
                            ],
                          ),
                        ),
                      ]);
                    }),
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
