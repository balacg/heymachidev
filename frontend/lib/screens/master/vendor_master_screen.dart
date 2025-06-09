import 'package:flutter/material.dart';

class VendorMasterScreen extends StatefulWidget {
  const VendorMasterScreen({super.key});

  @override
  State<VendorMasterScreen> createState() => _VendorMasterScreenState();
}

class _VendorMasterScreenState extends State<VendorMasterScreen> {
  List<Map<String, String>> vendors = [
    {
      'company': 'Ravi & Co',
      'phone': '9876543210',
      'email': 'ravi@example.com',
      'gstNumber': '33BBBBB1111B2Z6',
    },
    {
      'company': 'Sunil Traders',
      'phone': '9123456780',
      'email': 'sunil@example.com',
      'gstNumber': '',
    },
  ];

  void _showVendorDialog({int? index}) {
    final isEdit = index != null;
    final vendor = isEdit ? vendors[index] : null;

    final companyController = TextEditingController(text: vendor?['company'] ?? '');
    final phoneController = TextEditingController(text: vendor?['phone'] ?? '');
    final emailController = TextEditingController(text: vendor?['email'] ?? '');
    final gstController = TextEditingController(text: vendor?['gstNumber'] ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEdit ? 'Edit Vendor' : 'Add Vendor'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(controller: companyController, decoration: const InputDecoration(labelText: 'Company')),
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
                  final newVendor = {
                    'company': companyController.text,
                    'phone': phoneController.text,
                    'email': emailController.text,
                    'gstNumber': gstController.text,
                  };
                  if (isEdit) {
                    vendors[index!] = newVendor;
                  } else {
                    vendors.add(newVendor);
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

  void _deleteVendor(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Vendor'),
        content: const Text('Are you sure you want to delete this vendor?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                vendors.removeAt(index);
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
      appBar: AppBar(title: const Text('Vendor Master')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showVendorDialog(),
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
          columns: const [
            DataColumn(label: Text('No.', style: headerStyle)),
            DataColumn(label: Text('Company', style: headerStyle)),
            DataColumn(label: Text('Phone', style: headerStyle)),
            DataColumn(label: Text('Email', style: headerStyle)),
            DataColumn(label: Text('GST Number', style: headerStyle)),
            DataColumn(label: Text('Actions', style: headerStyle)),
          ],
          rows: List.generate(vendors.length, (index) {
            final vendor = vendors[index];
            return DataRow(
              cells: [
                DataCell(Text('${index + 1}')),
                DataCell(Text(vendor['company'] ?? '')),
                DataCell(Text(vendor['phone'] ?? '')),
                DataCell(Text(vendor['email'] ?? '')),
                DataCell(Text(vendor['gstNumber'] ?? '')),
                DataCell(
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        _showVendorDialog(index: index);
                      } else if (value == 'delete') {
                        _deleteVendor(index);
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
