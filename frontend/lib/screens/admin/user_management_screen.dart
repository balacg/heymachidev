// lib/screens/admin/user_management_screen.dart

import 'package:flutter/material.dart';

class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Management')),
      body: const Center(
        child: Text(
          'User management features will be implemented here.',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
