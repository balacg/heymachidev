// lib/screens/master/user_master_screen.dart

import 'package:flutter/material.dart';

class UserMasterScreen extends StatefulWidget {
  const UserMasterScreen({super.key});

  @override
  State<UserMasterScreen> createState() => _UserMasterScreenState();
}

class _UserMasterScreenState extends State<UserMasterScreen> {
  List<Map<String, String>> users = [
    {
      'name': 'Bala G',
      'role': 'Admin',
      'email': 'bala@example.com',
      'phone': '9876543210',
      'password': '********',
    },
    {
      'name': 'Ram',
      'role': 'Billing',
      'email': 'ram@example.com',
      'phone': '9123456780',
      'password': '********',
    },
  ];

  final List<String> roles = ['Admin', 'Billing', 'Manager', 'Viewer'];

  void _showUserDialog({int? index}) {
    final isEdit = index != null;
    final user = isEdit ? users[index] : null;

    final nameController = TextEditingController(text: user?['name'] ?? '');
    String selectedRole = user?['role'] ?? roles.first;
    final emailController = TextEditingController(text: user?['email'] ?? '');
    final phoneController = TextEditingController(text: user?['phone'] ?? '');
    final passwordController = TextEditingController(text: '');

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) {
          return AlertDialog(
            title: Text(isEdit ? 'Edit User' : 'Add User'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Name')),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: selectedRole,
                    items: roles.map((role) {
                      return DropdownMenuItem(value: role, child: Text(role));
                    }).toList(),
                    decoration: const InputDecoration(labelText: 'Role'),
                    onChanged: (value) {
                      if (value != null) {
                        setStateDialog(() {
                          selectedRole = value;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
                  const SizedBox(height: 10),
                  TextField(controller: phoneController, decoration: const InputDecoration(labelText: 'Phone'), keyboardType: TextInputType.phone),
                  const SizedBox(height: 10),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: isEdit ? 'New Password (leave blank to keep)' : 'Password',
                    ),
                    obscureText: true,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
              ElevatedButton(
                onPressed: () {
                  final name = nameController.text.trim();
                  final email = emailController.text.trim();
                  final phone = phoneController.text.trim();
                  final password = passwordController.text;

                  if (name.isEmpty || email.isEmpty || phone.isEmpty || (!isEdit && password.isEmpty)) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all required fields')));
                    return;
                  }

                  setState(() {
                    final newUser = {
                      'name': name,
                      'role': selectedRole,
                      'email': email,
                      'phone': phone,
                      'password': password.isEmpty && isEdit ? users[index!]['password']! : '********',
                    };
                    if (isEdit) {
                      users[index!] = newUser;
                    } else {
                      users.add(newUser);
                    }
                  });

                  Navigator.pop(context);
                },
                child: const Text('Save'),
              )
            ],
          );
        },
      ),
    );
  }

  void _deleteUser(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete User'),
        content: const Text('Are you sure you want to delete this user?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                users.removeAt(index);
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
      appBar: AppBar(title: const Text('User Management')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showUserDialog(),
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
          columns: const [
            DataColumn(label: Text('No.', style: headerStyle)),
            DataColumn(label: Text('Name', style: headerStyle)),
            DataColumn(label: Text('Role', style: headerStyle)),
            DataColumn(label: Text('Email', style: headerStyle)),
            DataColumn(label: Text('Phone', style: headerStyle)),
            DataColumn(label: Text('Password', style: headerStyle)),
            DataColumn(label: Text('Actions', style: headerStyle)),
          ],
          rows: List.generate(users.length, (index) {
            final user = users[index];
            return DataRow(
              cells: [
                DataCell(Text('${index + 1}')),
                DataCell(Text(user['name'] ?? '')),
                DataCell(Text(user['role'] ?? '')),
                DataCell(Text(user['email'] ?? '')),
                DataCell(Text(user['phone'] ?? '')),
                DataCell(Text(user['password'] ?? '')),
                DataCell(
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        _showUserDialog(index: index);
                      } else if (value == 'delete') {
                        _deleteUser(index);
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
