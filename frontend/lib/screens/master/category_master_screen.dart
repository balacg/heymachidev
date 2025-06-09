// lib/screens/master/category_master_screen.dart

import 'package:flutter/material.dart';

class CategoryMasterScreen extends StatefulWidget {
  const CategoryMasterScreen({super.key});

  @override
  State<CategoryMasterScreen> createState() => _CategoryMasterScreenState();
}

class _CategoryMasterScreenState extends State<CategoryMasterScreen> {
  int? selectedTaxId;

  final List<Map<String, dynamic>> taxList = [
    {'id': 1, 'name': 'GST 5%'},
    {'id': 2, 'name': 'GST 12%'},
    {'id': 3, 'name': 'GST 18%'},
    {'id': 4, 'name': 'GST 28%'},
  ];

  final TextEditingController categoryNameController = TextEditingController();

  @override
  void dispose() {
    categoryNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category Master'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: categoryNameController,
              decoration: const InputDecoration(labelText: 'Category Name'),
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
              onChanged: (val) => setState(() => selectedTaxId = val),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save logic here
              },
              child: const Text('Save'),
            )
          ],
        ),
      ),
    );
  }
}
