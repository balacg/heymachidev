// lib/screens/master/subcategory_master_screen.dart

import 'package:flutter/material.dart';

class SubcategoryMasterScreen extends StatefulWidget {
  const SubcategoryMasterScreen({super.key});

  @override
  State<SubcategoryMasterScreen> createState() => _SubcategoryMasterScreenState();
}

class _SubcategoryMasterScreenState extends State<SubcategoryMasterScreen> {
  int? selectedCategoryId;
  int? selectedSubcategoryId;
  int? selectedTaxId;

  final List<Map<String, dynamic>> categories = [
    {'id': 1, 'name': 'Food'},
    {'id': 2, 'name': 'Electronics'},
  ];

  final List<Map<String, dynamic>> subcategories = [
    {'id': 1, 'name': 'Beverages', 'categoryId': 1},
    {'id': 2, 'name': 'Snacks', 'categoryId': 1},
    {'id': 3, 'name': 'Mobiles', 'categoryId': 2},
    {'id': 4, 'name': 'Laptops', 'categoryId': 2},
  ];

  final List<Map<String, dynamic>> taxList = [
    {'id': 1, 'name': 'GST 5%'},
    {'id': 2, 'name': 'GST 12%'},
    {'id': 3, 'name': 'GST 18%'},
    {'id': 4, 'name': 'GST 28%'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subcategory Master'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<int>(
              decoration: const InputDecoration(labelText: 'Category'),
              value: selectedCategoryId,
              items: categories
                  .map((category) => DropdownMenuItem(
                        value: category['id'] as int,
                        child: Text(category['name'] as String),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategoryId = value;
                  selectedSubcategoryId = null; // reset subcategory
                });
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<int>(
              decoration: const InputDecoration(labelText: 'Subcategory'),
              value: selectedSubcategoryId,
              items: subcategories
                  .where((sub) => sub['categoryId'] == selectedCategoryId)
                  .map((sub) => DropdownMenuItem(
                        value: sub['id'] as int,
                        child: Text(sub['name'] as String),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedSubcategoryId = value;
                });
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<int>(
              decoration: const InputDecoration(labelText: 'Tax'),
              value: selectedTaxId,
              items: taxList
                  .map((tax) => DropdownMenuItem(
                        value: tax['id'] as int,
                        child: Text(tax['name'] as String),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedTaxId = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
