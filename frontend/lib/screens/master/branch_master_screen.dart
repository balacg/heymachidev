// lib/screens/master/branch_master_screen.dart

import 'package:flutter/material.dart';

class BranchMasterScreen extends StatefulWidget {
  const BranchMasterScreen({super.key});

  @override
  State<BranchMasterScreen> createState() => _BranchMasterScreenState();
}

class _BranchMasterScreenState extends State<BranchMasterScreen> {
  List<Map<String, String>> branches = [
    {
      'name': 'Udumalpet Main Branch',
      'address': '123 Main St, Udumalpet',
      'contact': '9876543210',
      'email': 'contact@udumalpetbranch.com',
    },
  ];

  void _showBranchDialog({int? index}) {
    final isEdit = index != null;
    final branch = isEdit ? branches[index] : null;

    final nameController = TextEditingController(text: branch?['name'] ?? '');
    final addressController = TextEditingController(text: branch?['address'] ?? '');
    final contactController = TextEditingController(text: branch?['contact'] ?? '');
    final emailController = TextEditingController(text: branch?['email'] ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEdit ? 'Edit Branch' : 'Add Branch'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Branch Name')),
              TextField(controller: addressController, decoration: const InputDecoration(labelText: 'Address')),
              TextField(controller: contactController, decoration: const InputDecoration(labelText: 'Contact Number'), keyboardType: TextInputType.phone),
              TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email'), keyboardType: TextInputType.emailAddress),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Branch name is required')));
                return;
              }
              setState(() {
                final newBranch = {
                  'name': nameController.text.trim(),
                  'address': addressController.text.trim(),
                  'contact': contactController.text.trim(),
                  'email': emailController.text.trim(),
                };
                if (isEdit) {
                  branches[index!] = newBranch;
                } else {
                  branches.add(newBranch);
                }
              });
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deleteBranch(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Branch'),
        content: const Text('Are you sure you want to delete this branch?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                branches.removeAt(index);
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
      appBar: AppBar(title: const Text('Branch Master')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showBranchDialog(),
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
          columns: const [
            DataColumn(label: Text('No.', style: headerStyle)),
            DataColumn(label: Text('Branch Name', style: headerStyle)),
            DataColumn(label: Text('Address', style: headerStyle)),
            DataColumn(label: Text('Contact Number', style: headerStyle)),
            DataColumn(label: Text('Email', style: headerStyle)),
            DataColumn(label: Text('Actions', style: headerStyle)),
          ],
          rows: List.generate(branches.length, (index) {
            final branch = branches[index];
            return DataRow(
              cells: [
                DataCell(Text('${index + 1}')),
                DataCell(Text(branch['name'] ?? '')),
                DataCell(Text(branch['address'] ?? '')),
                DataCell(Text(branch['contact'] ?? '')),
                DataCell(Text(branch['email'] ?? '')),
                DataCell(
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        _showBranchDialog(index: index);
                      } else if (value == 'delete') {
                        _deleteBranch(index);
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
