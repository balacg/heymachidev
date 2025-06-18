// heymachi/frontend/lib/utils/widget_utils.dart

import 'package:flutter/material.dart';
import '../screens/billing/item_catalog_page.dart';

Future<Map<String, dynamic>?> showItemCatalogPicker(
  BuildContext context, {
  Map<String, Map<String, dynamic>>? existingCart,
}) async {
  return await Navigator.pushNamed(
    context,
    '/product-selector',
    arguments: existingCart,
  ) as Map<String, dynamic>?;
}
