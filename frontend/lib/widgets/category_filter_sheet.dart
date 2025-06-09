import 'package:flutter/material.dart';

class CategoryFilterSheet extends StatelessWidget {
  final List<String> categories;
  final String selected;
  final Function(String) onSelected;

  const CategoryFilterSheet({
    super.key,
    required this.categories,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: const EdgeInsets.all(16),
      child: ListView(
        shrinkWrap: true,
        children: categories.map((cat) {
          final isSelected = cat == selected;
          return ListTile(
            title: Text(
              cat,
              style: TextStyle(
                color: isSelected ? Colors.orangeAccent : Colors.white,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            trailing: isSelected ? const Icon(Icons.check, color: Colors.orangeAccent) : null,
            onTap: () {
              onSelected(cat);
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }
}
