// lib/screens/admin/email_notification_templates_screen.dart

import 'package:flutter/material.dart';

class EmailTemplate {
  String id;
  String name;
  String subject;
  String body;

  EmailTemplate({
    required this.id,
    required this.name,
    required this.subject,
    required this.body,
  });
}

class EmailNotificationTemplatesScreen extends StatefulWidget {
  const EmailNotificationTemplatesScreen({super.key});

  @override
  State<EmailNotificationTemplatesScreen> createState() => _EmailNotificationTemplatesScreenState();
}

class _EmailNotificationTemplatesScreenState extends State<EmailNotificationTemplatesScreen> {
  List<EmailTemplate> templates = [
    EmailTemplate(
      id: '1',
      name: 'Vendor Payment Reminder',
      subject: 'Payment Due Reminder',
      body: 'Dear {vendor_name},\n\nYour payment of {amount} is due on {due_date}. Please arrange the payment at the earliest.\n\nThanks,\nHeyMachi Team',
    ),
    EmailTemplate(
      id: '2',
      name: 'Salary Disbursal Notification',
      subject: 'Your Salary Has Been Processed',
      body: 'Hello {employee_name},\n\nYour salary for {month} has been credited to your account.\n\nRegards,\nHR Team',
    ),
  ];

  final _formKey = GlobalKey<FormState>();
  String? _editingId;
  String _editingName = '';
  String _editingSubject = '';
  String _editingBody = '';

  void _openEditDialog([EmailTemplate? template]) {
    if (template != null) {
      _editingId = template.id;
      _editingName = template.name;
      _editingSubject = template.subject;
      _editingBody = template.body;
    } else {
      _editingId = null;
      _editingName = '';
      _editingSubject = '';
      _editingBody = '';
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(template == null ? 'Add Email Template' : 'Edit Email Template'),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: _editingName,
                  decoration: const InputDecoration(labelText: 'Template Name'),
                  validator: (val) => val == null || val.isEmpty ? 'Enter template name' : null,
                  onChanged: (val) => _editingName = val,
                ),
                TextFormField(
                  initialValue: _editingSubject,
                  decoration: const InputDecoration(labelText: 'Subject'),
                  validator: (val) => val == null || val.isEmpty ? 'Enter subject' : null,
                  onChanged: (val) => _editingSubject = val,
                ),
                TextFormField(
                  initialValue: _editingBody,
                  decoration: const InputDecoration(labelText: 'Body'),
                  maxLines: 6,
                  validator: (val) => val == null || val.isEmpty ? 'Enter email body' : null,
                  onChanged: (val) => _editingBody = val,
                ),
                const SizedBox(height: 8),
                const Text(
                  'You can use placeholders like {vendor_name}, {amount}, {due_date} in the body.',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  if (_editingId == null) {
                    templates.add(EmailTemplate(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: _editingName,
                      subject: _editingSubject,
                      body: _editingBody,
                    ));
                  } else {
                    final idx = templates.indexWhere((t) => t.id == _editingId);
                    if (idx != -1) {
                      templates[idx] = EmailTemplate(
                        id: _editingId!,
                        name: _editingName,
                        subject: _editingSubject,
                        body: _editingBody,
                      );
                    }
                  }
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deleteTemplate(String id) {
    setState(() {
      templates.removeWhere((t) => t.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Email Notification Templates')),
      body: ListView.separated(
        itemCount: templates.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final template = templates[index];
          return ListTile(
            title: Text(template.name),
            subtitle: Text(template.subject),
            trailing: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'edit') {
                  _openEditDialog(template);
                } else if (value == 'delete') {
                  _deleteTemplate(template.id);
                }
              },
              itemBuilder: (context) => const [
                PopupMenuItem(value: 'edit', child: Text('Edit')),
                PopupMenuItem(value: 'delete', child: Text('Delete')),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openEditDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
