// lib/screens/admin/admin_center_screen.dart

import 'package:flutter/material.dart';
import '../settings/business_profile_screen.dart';
import 'user_management_screen.dart';
import 'role_management_screen.dart';
import '../admin/email_notification_templates_screen.dart';
import '../notifications/notification_center_screen.dart';
import '../notifications/notification_settings_screen.dart';
import '../notifications/send_notification_mock_screen.dart';

class AdminCenterScreen extends StatelessWidget {
  const AdminCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Center')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Admin Dashboard',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('User Management'),
            subtitle: const Text('Manage users, roles, and permissions'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const UserManagementScreen()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.security),
            title: const Text('Role Management'),
            subtitle: const Text('Create, edit, and delete user roles'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RoleManagementScreen()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('System Configurations'),
            subtitle: const Text('Configure app-wide settings'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BusinessProfileScreen()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Audit Logs'),
            subtitle: const Text('View system activity logs'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Navigate to Audit Logs (coming soon)')),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notification Center'),
            subtitle: const Text('View internal alerts and actions'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationCenterScreen()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.tune),
            title: const Text('Notification Settings'),
            subtitle: const Text('Configure notification preferences'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationSettingsScreen()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.send),
            title: const Text('Send Notification (Mock)'),
            subtitle: const Text('Send test notifications'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SendNotificationMockScreen()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.email),
            title: const Text('Email Notification Templates'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EmailNotificationTemplatesScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
