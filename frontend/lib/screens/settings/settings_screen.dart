import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController gstNumberController = TextEditingController();
  final TextEditingController billFooterController = TextEditingController();

  @override
  void dispose() {
    businessNameController.dispose();
    gstNumberController.dispose();
    billFooterController.dispose();
    super.dispose();
  }

  void _saveSettings() {
    // TODO: Implement save logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Settings saved')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Business Settings',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: businessNameController,
              decoration: const InputDecoration(
                labelText: 'Business Name',
              ),
            ),
            TextField(
              controller: gstNumberController,
              decoration: const InputDecoration(
                labelText: 'GST Number (optional)',
              ),
            ),
            TextField(
              controller: billFooterController,
              decoration: const InputDecoration(
                labelText: 'Bill Footer Text',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveSettings,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
