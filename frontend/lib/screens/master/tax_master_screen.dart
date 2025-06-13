// lib/screens/master/tax_master_screen.dart

import 'package:flutter/material.dart';
import '../../services/api.dart';
import '../../models/tax.dart';
import '../../widgets/table_column.dart';
import '../../widgets/generic_data_table.dart';

class TaxMasterScreen extends StatefulWidget {
  const TaxMasterScreen({Key? key}) : super(key: key);

  @override
  State<TaxMasterScreen> createState() => _TaxMasterScreenState();
}

class _TaxMasterScreenState extends State<TaxMasterScreen> {
  List<Tax> _taxes = [];
  List<Tax> _allTaxes = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadTaxes();
  }

  Future<void> _loadTaxes() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      _allTaxes = await ApiService.fetchTaxes();
      _taxes = List.of(_allTaxes);
    } catch (e) {
      _error = e.toString();
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void _onSort(String field, bool asc) {
    setState(() {
      _taxes.sort((a, b) {
        final va = (a.toJson())[field];
        final vb = (b.toJson())[field];
        if (va is Comparable && vb is Comparable) {
          return asc ? va.compareTo(vb) : vb.compareTo(va);
        }
        return 0;
      });
    });
  }

  void _onFilter(String field, String query) {
    setState(() {
      _taxes = _allTaxes.where((t) {
        final val = (t.toJson())[field]?.toString().toLowerCase() ?? '';
        return val.contains(query.toLowerCase());
      }).toList();
    });
  }

  void _showForm({Tax? tax}) {
    final isEdit = tax != null;
    final typeCtl = TextEditingController(text: tax?.type ?? '');
    final rateCtl = TextEditingController(text: tax?.rate.toString() ?? '');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isEdit ? 'Edit Tax' : 'Add Tax'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: typeCtl, decoration: const InputDecoration(labelText: 'Type')),
              TextField(
                controller: rateCtl,
                decoration: const InputDecoration(labelText: 'Total Rate (%)'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              final type = typeCtl.text.trim();
              final rate = double.tryParse(rateCtl.text.trim()) ?? 0;

              if (type.isEmpty || rate <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Valid type & rate required')),
                );
                return;
              }

              final model = Tax(
                id: tax?.id ?? 0,
                type: type,
                rate: rate,
              );

              try {
                if (isEdit) {
                  await ApiService.updateTax(model);
                } else {
                  await ApiService.createTax(model);
                }
                Navigator.of(ctx).pop();
                await _loadTaxes();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deleteTax(int id) async {
    try {
      await ApiService.deleteTax(id);
      await _loadTaxes();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Delete failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tax Master')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Error: $_error'))
              : GenericDataTable<Tax>(
                  columns: [
                    TableColumn<Tax>(
                      title: 'ID',
                      field: 'id',
                      sortable: true,
                      frozen: true,
                      cellBuilder: (t) => Text('${t.id}'),
                    ),
                    TableColumn<Tax>(
                      title: 'Type',
                      field: 'type',
                      sortable: true,
                      filterable: true,
                    ),
                    TableColumn<Tax>(
                      title: 'Total Rate',
                      field: 'rate',
                      sortable: true,
                      cellBuilder: (t) => Text('${t.rate.toStringAsFixed(2)}%'),
                    ),
                    TableColumn<Tax>(
                      title: 'Actions',
                      field: 'actions',
                      cellBuilder: (t) => PopupMenuButton<String>(
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
                  ],
                  rows: _taxes,
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
