// lib/screens/master/payment_type_master_screen.dart

import 'package:flutter/material.dart';
import '../../services/api.dart';
import '../../models/payment_type.dart';

class PaymentTypeMasterScreen extends StatefulWidget {
  const PaymentTypeMasterScreen({super.key});
  @override
  State<PaymentTypeMasterScreen> createState() => _PaymentTypeMasterScreenState();
}

class _PaymentTypeMasterScreenState extends State<PaymentTypeMasterScreen> {
  List<PaymentType> _types = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadTypes();
  }

  Future<void> _loadTypes() async {
    setState(() { _loading = true; _error = null; });
    try {
      _types = await ApiService.fetchPaymentTypes();
    } catch (e) {
      _error = e.toString();
    } finally {
      setState(() { _loading = false; });
    }
  }

  void _showForm({PaymentType? pt}) {
    final isEdit = pt != null;
    final nameCtrl = TextEditingController(text: pt?.name ?? '');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isEdit ? 'Edit Payment Type' : 'Add Payment Type'),
        content: TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Name')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              final model = PaymentType(id: pt?.id ?? 0, name: nameCtrl.text);
              Navigator.pop(ctx);
              try {
                if (isEdit) await ApiService.updatePaymentType(model);
                else         await ApiService.createPaymentType(model);
                await _loadTypes();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error saving payment type: $e')),
                );
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deleteType(int id) async {
    await ApiService.deletePaymentType(id);
    _loadTypes();
  }

  @override
  Widget build(BuildContext context) {
    const headerStyle = TextStyle(fontWeight: FontWeight.bold);
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Type Master')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Error: $_error'))
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
                    columns: const [
                      DataColumn(label: Text('No.', style: headerStyle)),
                      DataColumn(label: Text('ID', style: headerStyle)),
                      DataColumn(label: Text('Name', style: headerStyle)),
                      DataColumn(label: Text('Actions', style: headerStyle)),
                    ],
                    rows: List<DataRow>.generate(_types.length, (i) {
                      final t = _types[i];
                      return DataRow(cells: [
                        DataCell(Text('${i + 1}')),
                        DataCell(Text('${t.id}')),
                        DataCell(Text(t.name)),
                        DataCell(
                          PopupMenuButton<String>(
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
                      ]);
                    }),
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
