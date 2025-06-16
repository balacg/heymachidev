// lib/screens/master/promotion_master_screen.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/promotion.dart';
import '../../services/promotion_service.dart';
import '../../widgets/generic_data_table.dart';
import '../../widgets/table_column.dart';

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
      final list = await PromotionService.fetchPromotions();
      setState(() {
        _allPromotions = list;
        _promotions = List.of(list);
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
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
        final val = p.toJson()[field]?.toString().toLowerCase() ?? '';
        return val.contains(query.toLowerCase());
      }).toList();
    });
  }

  void _showForm({Promotion? promo}) {
    final isEdit = promo != null;
    final titleCtl = TextEditingController(text: promo?.title ?? '');
    final descCtl = TextEditingController(text: promo?.description ?? '');
    final discountCtl = TextEditingController(text: promo?.discountPercentage.toString() ?? '');
    DateTime start = promo?.startDate ?? DateTime.now();
    DateTime end = promo?.endDate ?? DateTime.now().add(const Duration(days: 7));

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isEdit ? 'Edit Promotion' : 'Add Promotion'),
        content: StatefulBuilder(
          builder: (context, setState) => SingleChildScrollView(
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
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Start Date:"),
                    TextButton(
                      child: Text(DateFormat('yyyy-MM-dd').format(start)),
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: start,
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) setState(() => start = picked);
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("End Date:"),
                    TextButton(
                      child: Text(DateFormat('yyyy-MM-dd').format(end)),
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: end,
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) setState(() => end = picked);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              final title = titleCtl.text.trim();
              final desc = descCtl.text.trim();
              final discount = double.tryParse(discountCtl.text.trim()) ?? 0;

              if (title.isEmpty || discount <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Valid title & discount required')));
                return;
              }

              final model = Promotion(
                id: promo?.id ?? '', // Leave empty for add, must be non-null for update
                title: title,
                description: desc,
                discountPercentage: discount,
                startDate: start,
                endDate: end,
              );

              try {
                if (isEdit) {
                  await PromotionService.updatePromotion(model);
                } else {
                  await PromotionService.createPromotion(model);
                }
                if (!mounted) return;
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
      appBar: AppBar(title: const Text('Promotion Master')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Error: $_error'))
              : GenericDataTable<Promotion>(
                  columns: [
                    TableColumn<Promotion>(title: 'Title', field: 'title', filterable: true),
                    TableColumn<Promotion>(title: 'Description', field: 'description', filterable: true),
                    TableColumn<Promotion>(
                      title: 'Discount %',
                      field: 'discountPercentage',
                      sortable: true,
                      cellBuilder: (p) => Text('${p.discountPercentage.toStringAsFixed(1)}%'),
                    ),
                    TableColumn<Promotion>(
                      title: 'Start',
                      field: 'startDate',
                      cellBuilder: (p) => Text(DateFormat('yyyy-MM-dd').format(p.startDate)),
                    ),
                    TableColumn<Promotion>(
                      title: 'End',
                      field: 'endDate',
                      cellBuilder: (p) => Text(DateFormat('yyyy-MM-dd').format(p.endDate)),
                    ),
                    TableColumn<Promotion>(
                      title: 'Status',
                      field: 'status',
                      cellBuilder: (p) {
                        final expired = p.endDate.isBefore(DateTime.now());
                        return Text(
                          expired ? 'Expired' : 'Active',
                          style: TextStyle(color: expired ? Colors.red : Colors.green),
                        );
                      },
                    ),
                    TableColumn<Promotion>(
                      title: 'Actions',
                      field: 'actions',
                      cellBuilder: (p) => PopupMenuButton<String>(
                        onSelected: (val) {
                          if (val == 'edit') _showForm(promo: p);
                          if (val == 'delete') _deletePromotion(p.id ?? '');
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
