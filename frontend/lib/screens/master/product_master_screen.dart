import 'package:flutter/material.dart';

class ProductMasterScreen extends StatefulWidget {
  final int? categoryId;
  final int? subcategoryId;

  const ProductMasterScreen({
    super.key,
    this.categoryId,
    this.subcategoryId,
  });

  @override
  State<ProductMasterScreen> createState() => _ProductMasterScreenState();
}

class _ProductMasterScreenState extends State<ProductMasterScreen> {
  late int? selectedCategoryId;
  late int? selectedSubcategoryId;

  @override
  void initState() {
    super.initState();
    selectedCategoryId = widget.categoryId;
    selectedSubcategoryId = widget.subcategoryId;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Build your product master UI here
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Master'),
      ),
      body: Center(
        child: Text(
          'Category ID: ${selectedCategoryId ?? 'None'}\nSubcategory ID: ${selectedSubcategoryId ?? 'None'}',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
