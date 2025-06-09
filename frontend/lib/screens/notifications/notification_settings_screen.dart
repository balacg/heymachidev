// lib/screens/notifications/notification_settings_screen.dart

import 'package:flutter/material.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  Map<String, bool> notificationPreferences = {
    'Vendor Payments': true,
    'Employee Salaries': true,
    'Purchase Orders': true,
    'System Alerts': true,
    'Miscellaneous': true,
  };

  void _toggleNotification(String key, bool value) {
    setState(() {
      notificationPreferences[key] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Manage your notification preferences',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ...notificationPreferences.entries.map((entry) {
            return SwitchListTile(
              title: Text(entry.key),
              value: entry.value,
              onChanged: (val) => _toggleNotification(entry.key, val),
              activeColor: Colors.indigo,
            );
          }).toList(),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // TODO: Save preferences to backend or local storage
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notification preferences saved')),
              );
            },
            child: const Text('Save Preferences'),
          ),
        ],
      ),
    );
  }
}
