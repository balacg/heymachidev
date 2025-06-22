// lib/screens/master/product_master_screen.dart

import 'package:flutter/material.dart';
import 'package:heymachi_dev/models/tag.dart';
import 'package:heymachi_dev/services/tag_service.dart';
import 'package:heymachi_dev/utils/app_session.dart';
import '../../services/api.dart';
import '../../models/product.dart';
import '../../models/category.dart';
import '../../models/subcategory.dart';
import '../../models/tax.dart';
import '../../widgets/table_column.dart';
import '../../widgets/generic_data_table.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class ProductMasterScreen extends StatefulWidget {
  const ProductMasterScreen({Key? key}) : super(key: key);

  @override
  State<ProductMasterScreen> createState() => _ProductMasterScreenState();
}

class _ProductMasterScreenState extends State<ProductMasterScreen> {
  List<Product> _products = [];
  List<Product> _allProducts = [];
  List<Category> _categories = [];
  List<Subcategory> _subcategories = [];
  List<Tax> _taxes = [];

  List<Tag> _allTags = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    fetchTags();
    _loadAllData();
  }

  void fetchTags() async {
    try {
      final businessId = AppSession.instance.sessionData['business_id'];
      if (businessId == null) {
        debugPrint("❗ businessId is null. Cannot fetch tags.");
        return;
      }
      final tags = await TagService.fetchTags(businessId);

      setState(() {
        _allTags = tags;
      }); 
    } catch (e) {
      debugPrint("Error fetching tags: $e");
    }
  }

  Future<void> _loadAllData() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      _categories = await ApiService.fetchCategories();
      _taxes = await ApiService.fetchTaxes();
      final list = await ApiService.fetchProducts();
      _allProducts = list;
      _products = list;
    } catch (e) {
      _error = e.toString();
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void _deleteProduct(String id) async {
    try {
      await ApiService.deleteProduct(id);
      _loadAllData();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Delete failed: $e')));
    }
  }

  void _onSort(String field, bool asc) {
    setState(() {
      _products.sort((a, b) {
        switch (field) {
          case 'id':
            return asc ? a.id.compareTo(b.id) : b.id.compareTo(a.id);
          case 'name':
            return asc ? a.name.compareTo(b.name) : b.name.compareTo(a.name);
          case 'price':
            return asc ? a.price.compareTo(b.price) : b.price.compareTo(a.price);
          case 'categoryName':
            return asc ? a.categoryName.compareTo(b.categoryName) : b.categoryName.compareTo(a.categoryName);
          default:
            return 0;
        }
      });
    });
  }

  void _onFilter(String field, String query) {
    setState(() {
      _products = _allProducts.where((p) {
        switch (field) {
          case 'name':
            return p.name.toLowerCase().contains(query.toLowerCase());
          case 'categoryName':
            return p.categoryName.toLowerCase().contains(query.toLowerCase());
          default:
            return false;
        }
      }).toList();
    });
  }

  void _showForm({Product? product}) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController(text: product?.name ?? '');
    final priceController = TextEditingController(text: product?.price.toString() ?? '');
    int? selectedGstId = product?.gstId;
    String? selectedCategoryId = product?.categoryId;
    String? selectedSubcategoryId = product?.subcategoryId;

    List<Tag> selectedTags = _allTags.where((tag) => product?.tagIds?.contains(tag.id) ?? false).toList();

    if (product != null && product.categoryId != null) {
      ApiService.fetchSubcategories(categoryId: product.categoryId!).then((subs) {
        setState(() {
          _subcategories = subs;
        });
      });
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(product == null ? 'Add Product' : 'Edit Product'),
        content: StatefulBuilder(
          builder: (context, setModalState) {
            return Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Product Name'),
                    validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Price'),
                    validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedCategoryId,
                    items: _categories.map((c) => DropdownMenuItem(value: c.id, child: Text(c.name))).toList(),
                    onChanged: (val) async {
                      setModalState(() => selectedCategoryId = val);
                      final subs = await ApiService.fetchSubcategories(categoryId: val!);
                      setModalState(() {
                        _subcategories = subs;
                        selectedSubcategoryId = null;
                      });
                    },
                    decoration: const InputDecoration(labelText: 'Category'),
                    validator: (val) => val == null ? 'Select Category' : null,
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedSubcategoryId?.isEmpty == true ? null : selectedSubcategoryId,
                    items: _subcategories.map((s) => DropdownMenuItem(value: s.id, child: Text(s.name))).toList(),
                    onChanged: (val) => setModalState(() => selectedSubcategoryId = val),
                    decoration: const InputDecoration(labelText: 'Subcategory'),
                    validator: (val) => val == null || val.isEmpty ? 'Select Subcategory' : null,
                  ),
                  DropdownButtonFormField<int>(
                    value: selectedGstId,
                    items: _taxes.map((t) {
                      final label = '${t.type} (${t.rate.toStringAsFixed(1)}%)';
                      return DropdownMenuItem(value: t.id, child: Text(label));
                    }).toList(),
                    onChanged: (val) => setModalState(() => selectedGstId = val),
                    decoration: const InputDecoration(labelText: 'GST'),
                    validator: (val) => val == null ? 'Select GST' : null,
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.label),
                    label: const Text("Select Tags"),
                    onPressed: () {
                      _showTagSelector(context, _allTags, selectedTags, (selected) {
                        setModalState(() => selectedTags = selected);
                      });
                    },
                  ),
                  Wrap(
                    spacing: 6,
                    children: selectedTags.map((tag) {
                      return Chip(
                        label: Text(tag.tagValue),
                        onDeleted: () => setModalState(() => selectedTags.remove(tag)),
                      );
                    }).toList(),
                  ),




                ]),
              ),
            );
          },
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState?.validate() ?? false) {
                final productPayload = Product(
                  id: product?.id ?? '',
                  name: nameController.text.trim(),
                  price: double.tryParse(priceController.text) ?? 0,
                  categoryId: selectedCategoryId,
                  subcategoryId: selectedSubcategoryId,
                  gstId: selectedGstId,
                  unitId: null,
                  isActive: true,
                  tagIds: selectedTags.map((t) => t.id!).toList(),
                  businessId: '', // backend assigns
                  categoryName: '', // not needed in update
                );

                try {
                  if (product == null) {
                    await ApiService.createProduct(productPayload);
                  } else {
                    await ApiService.updateProduct(productPayload);
                  }
                  Navigator.pop(context);
                  _loadAllData();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed: $e')));
                }
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  String _getGstLabel(int? gstId) {
    final tax = _taxes.firstWhere((t) => t.id == gstId, orElse: () => Tax(id: 0, type: '', rate: 0));
    return tax.id == 0 ? '' : '${tax.type} (${tax.rate.toStringAsFixed(1)}%)';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Master')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Error: $_error'))
              : GenericDataTable<Product>(
                  columns: [
                    TableColumn<Product>(
                      title: 'No.',
                      field: 'no',
                      cellBuilder: (p) => Text('${_products.indexOf(p) + 1}'),
                      frozen: true,
                    ),
                    TableColumn<Product>(
                      title: 'ID',
                      field: 'id',
                      sortable: true,
                      frozen: true,
                      cellBuilder: (p) => Text('${p.id}'),
                    ),
                    TableColumn<Product>(
                      title: 'Name',
                      field: 'name',
                      sortable: true,
                      filterable: true,
                    ),
                    TableColumn<Product>(
                      title: 'Price',
                      field: 'price',
                      sortable: true,
                      cellBuilder: (p) => Text('₹${p.price.toStringAsFixed(2)}'),
                    ),
                    TableColumn<Product>(
                      title: 'Category',
                      field: 'categoryName',
                      sortable: true,
                      filterable: true,
                      cellBuilder: (p) => Text(p.categoryName),
                    ),
                    TableColumn<Product>(
                      title: 'Subcategory',
                      field: 'subcategoryName',
                      sortable: false,
                      cellBuilder: (p) => Text(p.subcategoryName ?? '-'),
                    ),
                    TableColumn<Product>(
                      title: 'GST',
                      field: 'gst',
                      cellBuilder: (p) => Text(_getGstLabel(p.gstId)),
                    ),
                    TableColumn<Product>(
                      title: 'Tags',
                      field: 'tags',
                      cellBuilder: (p) {
                        // Prefer hydrated tag list if available
                        if (p.tags != null && p.tags!.isNotEmpty) {
                          return Text(p.tags!.map((t) => t.tagValue).join(', '));
                        }

                        // Fallback to tagIds if tags are not hydrated
                        if (p.tagIds != null && p.tagIds!.isNotEmpty) {
                          final tagNames = _allTags
                              .where((tag) => p.tagIds!.contains(tag.id))
                              .map((t) => t.tagValue)
                              .join(', ');
                          return Text(tagNames);
                        }

                        return const Text('-');
                      },
                    ),

                    TableColumn<Product>(
                      title: 'Actions',
                      field: 'actions',
                      cellBuilder: (p) => PopupMenuButton<String>(
                        onSelected: (v) {
                          if (v == 'edit') _showForm(product: p);
                          else if (v == 'delete') _deleteProduct(p.id);
                        },
                        itemBuilder: (_) => const [
                          PopupMenuItem(value: 'edit', child: Text('Edit')),
                          PopupMenuItem(value: 'delete', child: Text('Delete')),
                        ],
                      ),
                    ),
                  ],
                  rows: _products,
                  onSort: _onSort,
                  onFilter: _onFilter,
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(),
        child: const Icon(Icons.add),
      ),
    );
  }

    void _showTagSelector(
      BuildContext context,
      List<Tag> allTags,
      List<Tag> selected,
      Function(List<Tag>) onConfirm,
    ) {
      final grouped = <String, List<Tag>>{};
      for (final tag in allTags) {
        grouped.putIfAbsent(tag.tagType, () => []).add(tag);
      }

      List<Tag> tempSelected = [...selected];
      String searchQuery = '';

      showDialog(
        context: context,
        builder: (_) {
          return StatefulBuilder(builder: (context, setState) {
            final filteredGrouped = {
              for (var entry in grouped.entries)
                entry.key: entry.value
                    .where((tag) =>
                        tag.tagValue.toLowerCase().contains(searchQuery.toLowerCase()))
                    .toList()
            };

            Color _getColor(String tagType) {
              final t = tagType.toLowerCase();
              if (t.contains('taste')) return Colors.orange.shade200;
              if (t.contains('occasion')) return Colors.green.shade200;
              if (t.contains('spice')) return Colors.red.shade200;
              if (t.contains('diet')) return Colors.purple.shade200;
              return Colors.blueGrey.shade200;
            }

            IconData _getIcon(String tagType) {
              final t = tagType.toLowerCase();
              if (t.contains('taste')) return Icons.restaurant;
              if (t.contains('occasion')) return Icons.event;
              if (t.contains('spice')) return Icons.whatshot;
              if (t.contains('diet')) return Icons.local_florist;
              return Icons.label;
            }

            return AlertDialog(
              title: const Text("Select Tags"),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.7,
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(hintText: "Search tags"),
                      onChanged: (val) => setState(() => searchQuery = val),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView(
                        children: filteredGrouped.entries.map((entry) {
                          return ExpansionTile(
                            title: Text(entry.key),
                            initiallyExpanded: true,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: entry.value.map((tag) {
                                    final isSelected = tempSelected.any((t) => t.id == tag.id);
                                    return FilterChip(
                                      avatar: Icon(
                                        isSelected ? Icons.check_circle : Icons.label_outline,
                                        size: 16,
                                        color: isSelected ? Colors.white : Colors.black54,
                                      ),
                                      label: Text(
                                        tag.tagValue,
                                        style: TextStyle(
                                          color: isSelected ? Colors.white : Colors.black,
                                        ),
                                      ),
                                      selected: isSelected,
                                      backgroundColor: isSelected ? Colors.deepPurple : Colors.grey.shade300,
                                      selectedColor: Colors.deepPurple,
                                      onSelected: (selected) {
                                        setState(() {
                                          if (selected) {
                                            tempSelected.add(tag);
                                          } else {
                                            tempSelected.removeWhere((t) => t.id == tag.id);
                                          }
                                        });
                                      },
                                    );
                                  }).toList(),
                                ),
                              )
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
                ElevatedButton(
                  onPressed: () {
                    onConfirm(tempSelected);
                    Navigator.pop(context);
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          });
        },
      );
    }
}
