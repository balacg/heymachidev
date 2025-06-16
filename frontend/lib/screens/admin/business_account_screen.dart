// lib/screens/admin/business_account_screen.dart

import 'package:flutter/material.dart';
import 'package:heymachi_dev/models/admin/business_account.dart';
import 'package:heymachi_dev/services/api.dart';

class BusinessAccountScreen extends StatefulWidget {
  const BusinessAccountScreen({super.key});

  @override
  State<BusinessAccountScreen> createState() => _BusinessAccountScreenState();
}

class _BusinessAccountScreenState extends State<BusinessAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String industryId = '';
  List<Map<String, String>> industries = [];

  @override
  void initState() {
    super.initState();
    fetchIndustries();
  }

  void fetchIndustries() async {
    final result = await ApiService.get('/industries');
    setState(() {
      industries = List<Map<String, String>>.from(result);
    });
  }

  void submit() async {
    if (_formKey.currentState!.validate()) {
      final data = {
        'name': name,
        'industry_id': industryId,
      };
      await ApiService.post('/business-accounts', data);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Business Account')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Business Name'),
                onChanged: (val) => name = val,
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Industry'),
                items: industries
                    .map((ind) => DropdownMenuItem(
                          value: ind['id'],
                          child: Text(ind['name'] ?? ''),
                        ))
                    .toList(),
                onChanged: (val) => industryId = val ?? '',
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: submit, child: const Text('Save')),
            ],
          ),
        ),
      ),
    );
  }
}
