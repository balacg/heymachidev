// heymachi/frontend/lib/utils/widget_utils.dart

import 'package:flutter/material.dart';
import '../screens/billing/item_catalog_page.dart';

Future<Map<String, dynamic>?> showItemCatalogPicker(BuildContext context) {
  return Navigator.push<Map<String, dynamic>>(
    context,
    MaterialPageRoute(
      builder: (_) => const ItemCatalogPage(isSelectorMode: true),
    ),
  );
}
