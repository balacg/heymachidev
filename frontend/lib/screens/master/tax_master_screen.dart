// lib/screens/master/tax_master_screen.dart

import 'package:flutter/material.dart';
import '../../services/api.dart';
import '../../models/tax.dart';

class TaxMasterScreen extends StatefulWidget {
  const TaxMasterScreen({super.key});
  @override
  State<TaxMasterScreen> createState() => _TaxMasterScreenState();
}

class _TaxMasterScreenState extends State<TaxMasterScreen> {
  List<Tax> _taxes = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadTaxes();
  }

  Future<void> _loadTaxes() async {
    setState(() { _loading = true; _error = null; });
    try {
      _taxes = await ApiService.fetchTaxes();
    } catch (e) {
      _error = e.toString();
    } finally {
      setState(() { _loading = false; });
    }
  }

  void _showForm({Tax? tax}) {
    final isEdit = tax != null;
    final typeCtrl = TextEditingController(text: tax?.type ?? '');
    final rateCtrl = TextEditingController(text: tax?.rate.toString() ?? '');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isEdit ? 'Edit Tax' : 'Add Tax'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: typeCtrl, decoration: const InputDecoration(labelText: 'Type (GST/VAT)')),
            TextField(
              controller: rateCtrl,
              decoration: const InputDecoration(labelText: 'Rate (%)'),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              final model = Tax(
                id: tax?.id ?? 0,
                type: typeCtrl.text,
                rate: double.tryParse(rateCtrl.text) ?? 0.0,
              );
              Navigator.pop(ctx);
              try {
                if (isEdit) await ApiService.updateTax(model);
                else         await ApiService.createTax(model);
                await _loadTaxes();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error saving tax: $e')),
                );
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deleteTax(int id) async {
    await ApiService.deleteTax(id);
    _loadTaxes();
  }

  @override
  Widget build(BuildContext context) {
    const headerStyle = TextStyle(fontWeight: FontWeight.bold);
    return Scaffold(
      appBar: AppBar(title: const Text('Tax Master')),
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
                      DataColumn(label: Text('Type', style: headerStyle)),
                      DataColumn(label: Text('Rate (%)', style: headerStyle)),
                      DataColumn(label: Text('Actions', style: headerStyle)),
                    ],
                    rows: List<DataRow>.generate(_taxes.length, (i) {
                      final t = _taxes[i];
                      return DataRow(cells: [
                        DataCell(Text('${i + 1}')),
                        DataCell(Text('${t.id}')),
                        DataCell(Text(t.type)),
                        DataCell(Text('${t.rate.toStringAsFixed(2)}%')),
                        DataCell(
                          PopupMenuButton<String>(
                            onSelected: (v) {
                              if (v == 'edit') _showForm(tax: t);
                              else if (v == 'delete') _deleteTax(t.id);
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
