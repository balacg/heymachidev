// lib/screens/master/user_master_screen.dart

import 'package:flutter/material.dart';
import '../../widgets/table_column.dart';
import '../../widgets/generic_data_table.dart';

class UserMasterScreen extends StatefulWidget {
  const UserMasterScreen({Key? key}) : super(key: key);

  @override
  State<UserMasterScreen> createState() => _UserMasterScreenState();
}

class _UserMasterScreenState extends State<UserMasterScreen> {
  List<Map<String, String>> _users = [
    {
      'name': 'Bala G',
      'role': 'Admin',
      'email': 'bala@example.com',
      'phone': '9999999999',
    },
    // ... other initial users
  ];
  List<Map<String, String>> _allUsers = [];

  @override
  void initState() {
    super.initState();
    _allUsers = List.from(_users);
  }

  void _showUserDialog({int? index}) {
    // ← your existing add/edit dialog code
  }

  void _deleteUser(int index) {
    setState(() {
      _users.removeAt(index);
      _allUsers = List.from(_users);
    });
  }

  void _onSort(String field, bool asc) {
    setState(() {
      _users.sort((a, b) {
        final va = a[field]!;
        final vb = b[field]!;
        return asc ? va.compareTo(vb) : vb.compareTo(va);
      });
    });
  }

  void _onFilter(String field, String query) {
    setState(() {
      _users = _allUsers
          .where((u) =>
              u[field]!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Management')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showUserDialog(),
        child: const Icon(Icons.add),
      ),
      body: GenericDataTable<Map<String, String>>(
        columns: [
          TableColumn<Map<String, String>>(
            title: 'Name',
            field: 'name',
            sortable: true,
            filterable: true,
          ),
          TableColumn<Map<String, String>>(
            title: 'Role',
            field: 'role',
            sortable: true,
            filterable: true,
          ),
          TableColumn<Map<String, String>>(
            title: 'Email',
            field: 'email',
            sortable: true,
            filterable: true,
          ),
          TableColumn<Map<String, String>>(
            title: 'Phone',
            field: 'phone',
            sortable: true,
            filterable: true,
          ),
          TableColumn<Map<String, String>>(
            title: 'Actions',
            field: 'actions',
            cellBuilder: (u) => PopupMenuButton<String>(
              onSelected: (v) {
                final idx = _users.indexOf(u);
                if (v == 'edit') _showUserDialog(index: idx);
                else if (v == 'delete') _deleteUser(idx);
              },
              itemBuilder: (_) => const [
                PopupMenuItem(value: 'edit', child: Text('Edit')),
                PopupMenuItem(value: 'delete', child: Text('Delete')),
              ],
            ),
          ),
        ],
        rows: _users,
        onSort: _onSort,
        onFilter: _onFilter,
      ),
    );
  }
}
