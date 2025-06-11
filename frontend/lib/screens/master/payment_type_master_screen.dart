// lib/screens/master/payment_type_master_screen.dart

import 'package:flutter/material.dart';
import '../../services/api.dart';
import '../../models/payment_type.dart';
import '../../widgets/table_column.dart';
import '../../widgets/generic_data_table.dart';

class PaymentTypeMasterScreen extends StatefulWidget {
  const PaymentTypeMasterScreen({Key? key}) : super(key: key);

  @override
  State<PaymentTypeMasterScreen> createState() =>
      _PaymentTypeMasterScreenState();
}

class _PaymentTypeMasterScreenState extends State<PaymentTypeMasterScreen> {
  List<PaymentType> _types = [];
  List<PaymentType> _allTypes = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadTypes();
  }

  Future<void> _loadTypes() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final list = await ApiService.fetchPaymentTypes();
      _allTypes = list;
      _types = list;
    } catch (e) {
      _error = e.toString();
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void _deleteType(int id) async {
    await ApiService.deletePaymentType(id);
    _loadTypes();
  }

  void _onSort(String field, bool asc) {
    setState(() {
      _types.sort((a, b) {
        final va = (a as dynamic)[field];
        final vb = (b as dynamic)[field];
        if (va is Comparable && vb is Comparable) {
          return asc ? va.compareTo(vb) : vb.compareTo(va);
        }
        return 0;
      });
    });
  }

  void _onFilter(String field, String query) {
    setState(() {
      _types = _allTypes
          .where((t) =>
              '${(t as dynamic)[field]}'.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _showForm({PaymentType? pt}) {
    // ← existing form code
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Type Master')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Error: $_error'))
              : GenericDataTable<PaymentType>(
                  columns: [
                    TableColumn<PaymentType>(
                      title: 'No.',
                      field: 'no',
                      cellBuilder: (t) => Text('${_types.indexOf(t) + 1}'),
                      frozen: true,
                    ),
                    TableColumn<PaymentType>(
                      title: 'ID',
                      field: 'id',
                      sortable: true,
                      frozen: true,
                      cellBuilder: (t) => Text('${t.id}'),
                    ),
                    TableColumn<PaymentType>(
                      title: 'Name',
                      field: 'name',
                      sortable: true,
                      filterable: true,
                    ),
                    TableColumn<PaymentType>(
                      title: 'Actions',
                      field: 'actions',
                      cellBuilder: (t) => PopupMenuButton<String>(
                        onSelected: (v) {
                          if (v == 'edit') _showForm(pt: t);
                          else if (v == 'delete') _deleteType(t.id);
                        },
                        itemBuilder: (_) => const [
                          PopupMenuItem(value: 'edit', child: Text('Edit')),
                          PopupMenuItem(value: 'delete', child: Text('Delete')),
                        ],
                      ),
                    ),
                  ],
                  rows: _types,
                  onSort: _onSort,
                  onFilter: _onFilter,
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
