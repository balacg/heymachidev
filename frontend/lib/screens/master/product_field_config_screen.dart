// lib/screens/master/product_field_config_screen.dart

import 'package:flutter/material.dart';

class ProductFieldConfigScreen extends StatefulWidget {
  const ProductFieldConfigScreen({super.key});

  @override
  State<ProductFieldConfigScreen> createState() => _ProductFieldConfigScreenState();
}

class _ProductFieldConfigScreenState extends State<ProductFieldConfigScreen> {
  Map<String, bool> fieldVisibility = {
    'Name': true,
    'Description': true,
    'Price': true,
    'GST': true,
    'Category': true,
    'Subcategory': true,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Field Configuration')),
      body: ListView(
        children: fieldVisibility.keys.map((field) {
          return SwitchListTile(
            title: Text(field),
            value: fieldVisibility[field] ?? true,
            onChanged: (val) {
              setState(() {
                fieldVisibility[field] = val;
              });
            },
          );
        }).toList(),
      ),
    );
  }
}
