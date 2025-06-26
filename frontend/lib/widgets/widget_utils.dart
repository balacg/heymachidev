// lib/shared/widget_utils.dart

import 'package:flutter/material.dart';
import 'package:heymachi_dev/screens/billing/item_catalog_page.dart';

Future<Map<String, dynamic>?> showItemCatalogPicker(BuildContext context) async {
  final result = await Navigator.push<Map<String, dynamic>>(
    context,
    MaterialPageRoute(
      builder: (_) => const ItemCatalogPage(), // Use correct constructor here
    ),
  );
  return result;
}
