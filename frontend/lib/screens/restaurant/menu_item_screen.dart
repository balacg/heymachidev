// lib/screens/restaurant/menu_item_screen.dart

import 'package:flutter/material.dart';
import 'package:heymachi_dev/models/restaurant/menu_item.dart';
import 'package:heymachi_dev/widgets/generic_master_screen.dart';

class MenuItemScreen extends StatelessWidget {
  const MenuItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GenericMasterScreen<MenuItem>(
      title: 'Menu Items',
      apiEndpoint: '/restaurant/menu-items',
      fromJson: (json) => MenuItem.fromJson(json),
      toJson: (item) => item.toJson(),
      buildFormFields: (item, onChanged) => [
        TextFormField(
          initialValue: item.name,
          decoration: const InputDecoration(labelText: 'Name'),
          onChanged: (val) => onChanged(item.copyWith(name: val)),
        ),
        TextFormField(
          initialValue: item.description,
          decoration: const InputDecoration(labelText: 'Description'),
          onChanged: (val) => onChanged(item.copyWith(description: val)),
        ),
        TextFormField(
          initialValue: item.price?.toString(),
          decoration: const InputDecoration(labelText: 'Price'),
          keyboardType: TextInputType.number,
          onChanged: (val) =>
              onChanged(item.copyWith(price: double.tryParse(val))),
        ),
      ],
      displayFields: (item) => [
        item.name,
        '₹${item.price?.toStringAsFixed(2) ?? "-"}',
        item.category ?? '',
      ],
    );
  }
}
