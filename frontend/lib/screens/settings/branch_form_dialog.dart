// lib/screens/settings/branch_form_dialog.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../services/api.dart';

class BranchFormDialog extends StatefulWidget {
  final Map<String, dynamic>? branch;
  const BranchFormDialog({super.key, this.branch});

  @override
  State<BranchFormDialog> createState() => _BranchFormDialogState();
}

class _BranchFormDialogState extends State<BranchFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController gstController = TextEditingController();

  final List<String> _indianStates = [
    'Andhra Pradesh', 'Arunachal Pradesh', 'Assam', 'Bihar', 'Chhattisgarh',
    'Goa', 'Gujarat', 'Haryana', 'Himachal Pradesh', 'Jharkhand', 'Karnataka',
    'Kerala', 'Madhya Pradesh', 'Maharashtra', 'Manipur', 'Meghalaya',
    'Mizoram', 'Nagaland', 'Odisha', 'Punjab', 'Rajasthan', 'Sikkim',
    'Tamil Nadu', 'Telangana', 'Tripura', 'Uttar Pradesh', 'Uttarakhand',
    'West Bengal', 'Andaman and Nicobar Islands', 'Chandigarh', 'Dadra and Nagar Haveli and Daman and Diu',
    'Delhi', 'Jammu and Kashmir', 'Ladakh', 'Lakshadweep', 'Puducherry',
  ];


  @override
  void initState() {
    super.initState();
    if (widget.branch != null) {
      nameController.text = widget.branch!['name'] ?? '';
      addressController.text = widget.branch!['address'] ?? '';
      stateController.text = widget.branch!['state'] ?? '';
      phoneController.text = widget.branch!['phone'] ?? '';
      emailController.text = widget.branch!['email'] ?? '';
      gstController.text = widget.branch!['gst_number'] ?? '';
    }
  }

  Future<void> _saveBranch() async {
    if (!_formKey.currentState!.validate()) return;

    final payload = {
      'name': nameController.text.trim(),
      'address': addressController.text.trim(),
      'state': stateController.text.trim(),
      'phone': phoneController.text.trim(),
      'email': emailController.text.trim(),
      'gst_number': gstController.text.trim(),
    };

    final isEdit = widget.branch != null;
    final uri = isEdit
        ? Uri.parse('${ApiService.baseUrl}/branches/${widget.branch!['id']}')
        : Uri.parse('${ApiService.baseUrl}/branches/');

    final method = isEdit ? http.put : http.post;

    final headers = ApiService.headers;
    print('🔐 Headers: $headers');
    print('📦 Payload: $payload');

    final resp = await method(
      uri,
      headers: headers,
      body: jsonEncode(payload),
    );

    print('📡 Response: ${resp.statusCode} - ${resp.body}');

    if (resp.statusCode == 200 || resp.statusCode == 201) {
      final result = jsonDecode(resp.body);
      Navigator.pop(context, result); // ✅ Send actual data back
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save: ${resp.statusCode}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.branch != null;
    return AlertDialog(
      title: Text(isEdit ? 'Edit Branch' : 'Add Branch'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Branch Name'),
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: addressController,
                decoration: const InputDecoration(labelText: 'Address'),
              ),
              DropdownButtonFormField<String>(
                value: stateController.text.isNotEmpty ? stateController.text : null,
                items: _indianStates.map((state) {
                  return DropdownMenuItem<String>(
                    value: state,
                    child: Text(state),
                  );
                }).toList(),
                decoration: const InputDecoration(labelText: 'State'),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => stateController.text = value);
                  }
                },
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),

              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: gstController,
                decoration: const InputDecoration(labelText: 'GST Number'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(onPressed: _saveBranch, child: const Text('Save')),
      ],
    );
  }
}
