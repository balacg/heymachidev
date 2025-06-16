// lib/screens/settings/business_profile_screen.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../services/api.dart';
import '../../widgets/generic_data_table.dart';
import '../../widgets/table_column.dart';
import 'branch_form_dialog.dart';

class BusinessProfileScreen extends StatefulWidget {
  const BusinessProfileScreen({super.key});

  @override
  State<BusinessProfileScreen> createState() => _BusinessProfileScreenState();
}

class _BusinessProfileScreenState extends State<BusinessProfileScreen> {
  Map<String, dynamic>? currentBranch;
  List<Map<String, dynamic>> allBranches = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBranches();
  }

  Future<void> _loadBranches() async {
    try {
      final uri = Uri.parse('${ApiService.baseUrl}/branches/');
      final headers = await ApiService.headers;
      final resp = await http.get(uri, headers: headers);
      if (resp.statusCode == 200) {
        final data = List<Map<String, dynamic>>.from(jsonDecode(resp.body));
        setState(() {
          allBranches = data;
          currentBranch = data.isNotEmpty ? data[0] : null;
          _isLoading = false;
        });
      } else {
        debugPrint('Failed with status: ${resp.statusCode}');
        setState(() => _isLoading = false);
      }
    } catch (e) {
      debugPrint("Failed to load branches: $e");
      setState(() => _isLoading = false);
    }
  }

  void _editCurrentBranch() async {
    final updated = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) => BranchFormDialog(branch: currentBranch),
    );
    if (updated != null) _loadBranches();
  }

  void _editBranch(Map<String, dynamic> branch) async {
    final updated = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) => BranchFormDialog(branch: branch),
    );
    if (updated != null) _loadBranches();
  }

  void _deleteBranch(String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this branch?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete')),
        ],
      ),
    );
    if (confirm == true) {
      final uri = Uri.parse('${ApiService.baseUrl}/branches/$id');
      await http.delete(uri);
      _loadBranches();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Profile'),
        actions: [
          if (currentBranch != null)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: _editCurrentBranch,
            ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final created = await showDialog<Map<String, dynamic>>(
                context: context,
                builder: (_) => const BranchFormDialog(),
              );
              if (created != null) _loadBranches();
            },
          ),
        ],
      ),

      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  const Text('Current Branch', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  if (currentBranch != null)
                    Card(
                      child: ListTile(
                        title: Text(currentBranch!['name']),
                        subtitle: Text(
                          '${currentBranch!['address'] ?? ''}\n'
                          '${currentBranch!['state']} | GST: ${currentBranch!['gst_number'] ?? ''}',
                        ),
                        isThreeLine: true,
                      ),
                    ),
                  const SizedBox(height: 30),
                  const Text('All Branches', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 500,
                    child: GenericDataTable<Map<String, dynamic>>(
                      rows: allBranches,
                      columns: [
                        TableColumn<Map<String, dynamic>>(
                          title: 'Branch Name',
                          field: 'name',
                          filterable: true,
                          sortable: true,
                          cellBuilder: (row) => Text(row['name'] ?? ''),
                        ),
                        TableColumn<Map<String, dynamic>>(
                          title: 'Address',
                          field: 'address',
                          filterable: true,
                          cellBuilder: (row) => Text(row['address'] ?? ''),
                        ),
                        TableColumn<Map<String, dynamic>>(
                          title: 'State',
                          field: 'state',
                          filterable: true,
                          cellBuilder: (row) => Text(row['state'] ?? ''),
                        ),
                        TableColumn<Map<String, dynamic>>(
                          title: 'Phone',
                          field: 'phone',
                          cellBuilder: (row) => Text(row['phone'] ?? ''),
                        ),
                        TableColumn<Map<String, dynamic>>(
                          title: 'Email',
                          field: 'email',
                          cellBuilder: (row) => Text(row['email'] ?? ''),
                        ),
                        TableColumn<Map<String, dynamic>>(
                          title: 'GST Number',
                          field: 'gst_number',
                          cellBuilder: (row) => Text(row['gst_number'] ?? ''),
                        ),
                        TableColumn<Map<String, dynamic>>(
                          title: 'Actions',
                          field: 'actions',
                          frozen: true,
                          cellBuilder: (row) => Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, size: 18),
                                onPressed: () => _editBranch(row),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, size: 18),
                                onPressed: () => _deleteBranch(row['id']),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
