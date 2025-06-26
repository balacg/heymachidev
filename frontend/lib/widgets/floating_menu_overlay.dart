// lib/widgets/floating_menu_overlay.dart

import 'package:flutter/material.dart';
import 'package:heymachi_dev/models/category.dart';
import 'package:heymachi_dev/models/subcategory.dart';

class FloatingMenuOverlay extends StatelessWidget {
  final List<Category> categories;
  final Map<String, List<Subcategory>> subcategoriesByCategory;
  final Map<String, int> productCounts;
  final Function(String subcategoryId) onSubcategorySelected;
  final VoidCallback onClose;

  const FloatingMenuOverlay({
    super.key,
    required this.categories,
    required this.subcategoriesByCategory,
    required this.productCounts,
    required this.onSubcategorySelected,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.8),
      child: Stack(
        children: [
          Positioned.fill(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                const Center(
                  child: Text(
                    "Select Menu",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: categories.map((category) {
                      final subs = subcategoriesByCategory[category.id] ?? [];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 8),
                            child: Text(
                              category.name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          if (subs.isNotEmpty)
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: subs.map((sub) {
                                final count = productCounts[sub.id] ?? 0;
                                return GestureDetector(
                                  onTap: () => onSubcategorySelected(sub.id),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      '${sub.name}${count > 0 ? ' ($count)' : ''}',
                                      style: const TextStyle(fontSize: 13, color: Colors.black),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 24,
            right: 24,
            child: FloatingActionButton.small(
              backgroundColor: Colors.black,
              onPressed: onClose,
              child: const Icon(Icons.close, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
