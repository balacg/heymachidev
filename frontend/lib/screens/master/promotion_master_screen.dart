// lib/screens/master/promotion_master_screen.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../services/promotion_service.dart';
import '../../models/promotion.dart';
import '../../widgets/table_column.dart';
import '../../widgets/generic_data_table.dart';

class PromotionMasterScreen extends StatefulWidget {
  const PromotionMasterScreen({Key? key}) : super(key: key);

  @override
  State<PromotionMasterScreen> createState() => _PromotionMasterScreenState();
}

class _PromotionMasterScreenState extends State<PromotionMasterScreen> {
  List<Promotion> _promotions = [];
  List<Promotion> _allPromotions = [];
  bool _loading = true;
  String? _error;

  final dateFormat = DateFormat('yyyy-MM-dd HH:mm');

  @override
  void initState() {
    super.initState();
    _loadPromotions();
  }

  Future<void> _loadPromotions() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      _allPromotions = await PromotionService.fetchPromotions();
      _promotions = List.of(_allPromotions);
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
      _promotions.sort((a, b) {
        final va = a.toJson()[field];
        final vb = b.toJson()[field];
        if (va is Comparable && vb is Comparable) {
          return asc ? va.compareTo(vb) : vb.compareTo(va);
        }
        return 0;
      });
    });
  }

  void _onFilter(String field, String query) {
    setState(() {
      _promotions = _allPromotions.where((p) {
        final val = (p.toJson()[field]?.toString().toLowerCase() ?? '');
        return val.contains(query.toLowerCase());
      }).toList();
    });
  }

  void _showForm({Promotion? promo}) {
    final isEdit = promo != null;
    final titleCtl = TextEditingController(text: promo?.title ?? '');
    final descCtl = TextEditingController(text: promo?.description ?? '');
    final discountCtl = TextEditingController(text: promo?.discountPercentage.toString() ?? '');
    final startCtl = TextEditingController(text: promo != null ? dateFormat.format(promo.startDate) : '');
    final endCtl = TextEditingController(text: promo != null ? dateFormat.format(promo.endDate) : '');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isEdit ? 'Edit Promotion' : 'Add Promotion'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: titleCtl, decoration: const InputDecoration(labelText: 'Title')),
              TextField(controller: descCtl, decoration: const InputDecoration(labelText: 'Description')),
              TextField(
                controller: discountCtl,
                decoration: const InputDecoration(labelText: 'Discount %'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              TextField(controller: startCtl, decoration: const InputDecoration(labelText: 'Start Date (yyyy-MM-dd HH:mm)')),
              TextField(controller: endCtl, decoration: const InputDecoration(labelText: 'End Date (yyyy-MM-dd HH:mm)')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              try {
                final newPromo = Promotion(
                  id: promo?.id,
                  title: titleCtl.text.trim(),
                  description: descCtl.text.trim(),
                  discountPercentage: double.tryParse(discountCtl.text.trim()) ?? 0,
                  startDate: dateFormat.parse(startCtl.text.trim()),
                  endDate: dateFormat.parse(endCtl.text.trim()),
                );
                if (isEdit) {
                  await PromotionService.updatePromotion(newPromo);
                } else {
                  await PromotionService.createPromotion(newPromo);
                }
                Navigator.of(ctx).pop();
                await _loadPromotions();
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

  void _deletePromotion(String id) async {
    try {
      await PromotionService.deletePromotion(id);
      await _loadPromotions();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Delete failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Promotions')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Error: $_error'))
              : GenericDataTable<Promotion>(
                  columns: [
                    TableColumn(title: 'Title', field: 'title', filterable: true, sortable: true),
                    TableColumn(title: 'Description', field: 'description'),
                    TableColumn(
                      title: 'Discount %',
                      field: 'discountPercentage',
                      sortable: true,
                      cellBuilder: (p) => Text('${p.discountPercentage.toStringAsFixed(2)}%'),
                    ),
                    TableColumn(
                      title: 'Start Date',
                      field: 'startDate',
                      cellBuilder: (p) => Text(dateFormat.format(p.startDate)),
                    ),
                    TableColumn(
                      title: 'End Date',
                      field: 'endDate',
                      cellBuilder: (p) => Text(dateFormat.format(p.endDate)),
                    ),
                    TableColumn(
                      title: 'Actions',
                      field: 'actions',
                      cellBuilder: (p) => PopupMenuButton<String>(
                        onSelected: (v) {
                          if (v == 'edit') _showForm(promo: p);
                          if (v == 'delete') _deletePromotion(p.id!);
                        },
                        itemBuilder: (_) => const [
                          PopupMenuItem(value: 'edit', child: Text('Edit')),
                          PopupMenuItem(value: 'delete', child: Text('Delete')),
                        ],
                      ),
                    ),
                  ],
                  rows: _promotions,
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
