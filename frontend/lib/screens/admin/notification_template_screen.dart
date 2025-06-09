// lib/screens/admin/notification_template_screen.dart

import 'package:flutter/material.dart';

enum TemplateType { email, sms }

class NotificationTemplate {
  String id;
  TemplateType type;
  String subject;
  String body;

  NotificationTemplate({
    required this.id,
    required this.type,
    required this.subject,
    required this.body,
  });
}

class NotificationTemplateScreen extends StatefulWidget {
  const NotificationTemplateScreen({super.key});

  @override
  State<NotificationTemplateScreen> createState() => _NotificationTemplateScreenState();
}

class _NotificationTemplateScreenState extends State<NotificationTemplateScreen> {
  List<NotificationTemplate> templates = [
    NotificationTemplate(
      id: '1',
      type: TemplateType.email,
      subject: 'Vendor Payment Reminder',
      body: 'Dear {vendor_name}, your payment of {amount} is due on {due_date}.',
    ),
    NotificationTemplate(
      id: '2',
      type: TemplateType.sms,
      subject: '',
      body: 'Payment of {amount} due on {due_date}. Please pay promptly.',
    ),
  ];

  final _formKey = GlobalKey<FormState>();
  TemplateType? _editingType;
  String _editingSubject = '';
  String _editingBody = '';
  String? _editingId;

  void _openEditDialog([NotificationTemplate? template]) {
    if (template != null) {
      _editingId = template.id;
      _editingType = template.type;
      _editingSubject = template.subject;
      _editingBody = template.body;
    } else {
      _editingId = null;
      _editingType = null;
      _editingSubject = '';
      _editingBody = '';
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(template == null ? 'Add Template' : 'Edit Template'),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<TemplateType>(
                  decoration: const InputDecoration(labelText: 'Type'),
                  value: _editingType,
                  items: TemplateType.values.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type.name.toUpperCase()),
                    );
                  }).toList(),
                  validator: (val) => val == null ? 'Select a template type' : null,
                  onChanged: (val) => setState(() {
                    _editingType = val;
                  }),
                ),
                if (_editingType == TemplateType.email)
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Subject'),
                    initialValue: _editingSubject,
                    validator: (val) => (val == null || val.isEmpty) ? 'Subject is required' : null,
                    onChanged: (val) => _editingSubject = val,
                  ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Body'),
                  maxLines: 5,
                  initialValue: _editingBody,
                  validator: (val) => (val == null || val.isEmpty) ? 'Body is required' : null,
                  onChanged: (val) => _editingBody = val,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Use placeholders like {vendor_name}, {amount}, {due_date} in body',
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
                    templates.add(NotificationTemplate(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      type: _editingType!,
                      subject: _editingSubject,
                      body: _editingBody,
                    ));
                  } else {
                    final idx = templates.indexWhere((t) => t.id == _editingId);
                    if (idx != -1) {
                      templates[idx] = NotificationTemplate(
                        id: _editingId!,
                        type: _editingType!,
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
      appBar: AppBar(title: const Text('Notification Templates')),
      body: ListView.separated(
        itemCount: templates.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final t = templates[index];
          return ListTile(
            leading: Icon(t.type == TemplateType.email ? Icons.email : Icons.sms),
            title: Text(t.type == TemplateType.email ? t.subject : '(SMS Template)'),
            subtitle: Text(t.body, maxLines: 2, overflow: TextOverflow.ellipsis),
            trailing: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'edit') {
                  _openEditDialog(t);
                } else if (value == 'delete') {
                  _deleteTemplate(t.id);
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
