// lib/screens/notifications/send_notification_mock_screen.dart

import 'package:flutter/material.dart';

class SendNotificationMockScreen extends StatefulWidget {
  const SendNotificationMockScreen({super.key});

  @override
  State<SendNotificationMockScreen> createState() => _SendNotificationMockScreenState();
}

class _SendNotificationMockScreenState extends State<SendNotificationMockScreen> {
  final _formKey = GlobalKey<FormState>();

  String _notificationType = 'Vendor Payment Reminder';
  final TextEditingController _messageController = TextEditingController();

  final List<String> _notificationTypes = [
    'Vendor Payment Reminder',
    'Salary Alert',
    'Purchase Order Alert',
    'General Notification',
  ];

  void _sendNotification() {
    if (_formKey.currentState!.validate()) {
      final message = _messageController.text.trim();

      // For now, just show a snackbar with info, later connect with NotificationCenter
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sent "$_notificationType": $message')),
      );

      _messageController.clear();
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Notification (Mock)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _notificationType,
                items: _notificationTypes
                    .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _notificationType = val;
                    });
                  }
                },
                decoration: const InputDecoration(labelText: 'Notification Type'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _messageController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Message',
                  border: OutlineInputBorder(),
                ),
                validator: (val) =>
                    val == null || val.trim().isEmpty ? 'Please enter a message' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _sendNotification,
                child: const Text('Send'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
