// lib/screens/admin/role_management_screen.dart

import 'package:flutter/material.dart';

class RoleManagementScreen extends StatelessWidget {
  const RoleManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Role Management')),
      body: const Center(
        child: Text(
          'Role management features will be implemented here.',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
