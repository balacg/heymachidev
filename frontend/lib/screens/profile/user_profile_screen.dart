// lib/screens/profile/user_profile_screen.dart

import 'package:flutter/material.dart';
import '../../../main.dart';

class UserProfileScreen extends StatelessWidget {
  final String userName;
  final String userEmail;
  final String userRole;
  final bool showAdminSettings;

  const UserProfileScreen({
    Key? key,
    required this.userName,
    required this.userEmail,
    required this.userRole,
    this.showAdminSettings = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(userName),
            subtitle: Text(userEmail),
          ),
          ListTile(
            leading: const Icon(Icons.badge),
            title: const Text('Role'),
            subtitle: Text(userRole),
          ),

          // Dark Mode toggle
          ValueListenableBuilder<ThemeMode>(
            valueListenable: themeNotifier,
            builder: (context, mode, _) {
              return SwitchListTile(
                secondary: const Icon(Icons.dark_mode),
                title: const Text('Dark Mode'),
                value: mode == ThemeMode.dark,
                onChanged: (isDark) {
                  themeNotifier.value =
                      isDark ? ThemeMode.dark : ThemeMode.light;
                },
              );
            },
          ),

          if (showAdminSettings)
            ListTile(
              leading: const Icon(Icons.admin_panel_settings),
              title: const Text('Admin Center'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => Navigator.pushNamed(context, '/admin_center'),
            ),
        ],
      ),
    );
  }
}
