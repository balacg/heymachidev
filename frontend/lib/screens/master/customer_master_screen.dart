// lib/screens/master/customer_master_screen.dart

import 'package:flutter/material.dart';
import '../../services/api.dart';
import '../../models/customer.dart';
import '../../widgets/table_column.dart';
import '../../widgets/generic_data_table.dart';

class CustomerMasterScreen extends StatefulWidget {
  const CustomerMasterScreen({Key? key}) : super(key: key);

  @override
  State<CustomerMasterScreen> createState() => _CustomerMasterScreenState();
}

class _CustomerMasterScreenState extends State<CustomerMasterScreen> {
  List<Customer> _customers    = [];
  List<Customer> _allCustomers = [];
  bool           _loading      = true;
  String?        _error;

  @override
  void initState() {
    super.initState();
    _loadCustomers();
  }

  Future<void> _loadCustomers() async {
    setState(() {
      _loading = true;
      _error   = null;
    });
    try {
      _allCustomers = await ApiService.fetchCustomers();
      _customers    = List.of(_allCustomers);
    } catch (e) {
      _error = e.toString();
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void _onSort(String field, bool asc) {
    setState(() {
      _customers.sort((a, b) {
        final va = (a.toJson())[field];
        final vb = (b.toJson())[field];
        if (va is Comparable && vb is Comparable) {
          return asc ? va.compareTo(vb) : vb.compareTo(va);
        }
        return 0;
      });
    });
  }

  void _onFilter(String field, String query) {
    setState(() {
      _customers = _allCustomers.where((c) {
        final val = (c.toJson())[field]?.toString().toLowerCase() ?? '';
        return val.contains(query.toLowerCase());
      }).toList();
    });
  }

  void _showForm({Customer? customer}) {
    final isEdit   = customer != null;
    final nameCtl  = TextEditingController(text: customer?.name ?? '');
    final phoneCtl = TextEditingController(text: customer?.phone ?? '');
    final emailCtl = TextEditingController(text: customer?.email ?? '');
    final gstCtl   = TextEditingController(text: customer?.gst ?? '');
    final addrCtl  = TextEditingController(text: customer?.address ?? '');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isEdit ? 'Edit Customer' : 'Add Customer'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtl,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: phoneCtl,
                decoration: const InputDecoration(labelText: 'Phone'),
              ),
              TextField(
                controller: emailCtl,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: gstCtl,
                decoration: const InputDecoration(labelText: 'GST Number'),
              ),
              TextField(
                controller: addrCtl,
                decoration: const InputDecoration(labelText: 'Address'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final name    = nameCtl.text.trim();
              final phone   = phoneCtl.text.trim();
              final email   = emailCtl.text.trim();
              final gstNum  = gstCtl.text.trim();
              final address = addrCtl.text.trim();

              if (name.isEmpty || phone.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Name & phone are required')),
                );
                return;
              }

              final model = Customer(
                id:        customer?.id ?? 0,
                name:      name,
                phone:     phone,
                email:     email.isEmpty ? null : email,
                gst: gstNum.isEmpty ? null : gstNum,
                address:   address.isEmpty ? null : address,
              );

              try {
                if (isEdit) {
                  await ApiService.updateCustomer(model);
                } else {
                  await ApiService.addCustomer(model);
                }
                Navigator.of(ctx).pop();
              } catch (e) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Error: $e')));
                return;
              }
              await _loadCustomers();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deleteCustomer(int id) async {
    try {
      await ApiService.deleteCustomer(id);
      await _loadCustomers();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Delete failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customer Master')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Error: $_error'))
              : GenericDataTable<Customer>(
                  columns: [
                    TableColumn<Customer>(
                      title: 'ID',
                      field: 'id',
                      sortable: true,
                      frozen: true,
                      cellBuilder: (c) => Text('${c.id}'),
                    ),
                    TableColumn<Customer>(
                      title: 'Name',
                      field: 'name',
                      sortable: true,
                      filterable: true,
                    ),
                    TableColumn<Customer>(
                      title: 'Phone',
                      field: 'phone',
                      sortable: true,
                      filterable: true,
                    ),
                    TableColumn<Customer>(
                      title: 'Email',
                      field: 'email',
                      sortable: true,
                      filterable: true,
                    ),
                    TableColumn<Customer>(
                      title: 'GST No.',
                      field: 'gst',
                      sortable: true,
                      filterable: true,
                    ),
                    TableColumn<Customer>(
                      title: 'Address',
                      field: 'address',
                      sortable: true,
                      filterable: true,
                    ),
                    TableColumn<Customer>(
                      title: 'Actions',
                      field: 'actions',
                      cellBuilder: (c) => PopupMenuButton<String>(
                        onSelected: (v) {
                          if (v == 'edit') _showForm(customer: c);
                          else if (v == 'delete') _deleteCustomer(c.id);
                        },
                        itemBuilder: (_) => const [
                          PopupMenuItem(value: 'edit', child: Text('Edit')),
                          PopupMenuItem(value: 'delete', child: Text('Delete')),
                        ],
                      ),
                    ),
                  ],
                  rows: _customers,
                  onSort: _onSort,
                  onFilter: _onFilter,
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
