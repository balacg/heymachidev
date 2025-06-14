// lib/models/restaurant/menu_subcategory.dart

class MenuSubcategory {
  final String id;
  final String name;
  final String categoryId;
  final String categoryName;
  final bool isActive;

  MenuSubcategory({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.categoryName,
    required this.isActive,
  });

  factory MenuSubcategory.fromJson(Map<String, dynamic> json) {
    return MenuSubcategory(
      id: json['id'],
      name: json['name'],
      categoryId: json['categoryId'],
      categoryName: json['categoryName'] ?? '',
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'categoryId': categoryId,
      'isActive': isActive,
    };
  }
}
