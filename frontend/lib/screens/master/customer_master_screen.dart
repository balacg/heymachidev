// lib/screens/master/customer_master_screen.dart

import 'package:flutter/material.dart';

class CustomerMasterScreen extends StatefulWidget {
  const CustomerMasterScreen({super.key});

  @override
  State<CustomerMasterScreen> createState() => _CustomerMasterScreenState();
}

class _CustomerMasterScreenState extends State<CustomerMasterScreen> {
  List<Map<String, String>> customers = [
    {
      'name': 'Arun Kumar',
      'phone': '9876543210',
      'email': 'arun@example.com',
      'gstNumber': '22AAAAA0000A1Z5',
    },
    {
      'name': 'Deepa R',
      'phone': '9123456780',
      'email': 'deepa@example.com',
      'gstNumber': '',
    },
  ];

  void _showCustomerDialog({int? index}) {
    final isEdit = index != null;
    final customer = isEdit ? customers[index] : null;

    final nameController = TextEditingController(text: customer?['name'] ?? '');
    final phoneController = TextEditingController(text: customer?['phone'] ?? '');
    final emailController = TextEditingController(text: customer?['email'] ?? '');
    final gstController = TextEditingController(text: customer?['gstNumber'] ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEdit ? 'Edit Customer' : 'Add Customer'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Name')),
                TextField(controller: phoneController, decoration: const InputDecoration(labelText: 'Phone')),
                TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
                TextField(controller: gstController, decoration: const InputDecoration(labelText: 'GST Number')),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  final newCustomer = {
                    'name': nameController.text,
                    'phone': phoneController.text,
                    'email': emailController.text,
                    'gstNumber': gstController.text,
                  };
                  if (isEdit) {
                    customers[index!] = newCustomer;
                  } else {
                    customers.add(newCustomer);
                  }
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteCustomer(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Customer'),
        content: const Text('Are you sure you want to delete this customer?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                customers.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text('Delete'),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCustomerDialog(),
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
          columns: const [
            DataColumn(label: Text('No.', style: headerStyle)),
            DataColumn(label: Text('Name', style: headerStyle)),
            DataColumn(label: Text('Phone', style: headerStyle)),
            DataColumn(label: Text('Email', style: headerStyle)),
            DataColumn(label: Text('GST Number', style: headerStyle)),
            DataColumn(label: Text('Actions', style: headerStyle)),
          ],
          rows: List.generate(customers.length, (index) {
            final customer = customers[index];
            return DataRow(
              cells: [
                DataCell(Text('${index + 1}')),
                DataCell(Text(customer['name'] ?? '')),
                DataCell(Text(customer['phone'] ?? '')),
                DataCell(Text(customer['email'] ?? '')),
                DataCell(Text(customer['gstNumber'] ?? '')),
                DataCell(
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        _showCustomerDialog(index: index);
                      } else if (value == 'delete') {
                        _deleteCustomer(index);
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
