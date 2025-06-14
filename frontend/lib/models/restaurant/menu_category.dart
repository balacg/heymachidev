// lib/models/restaurant/menu_category.dart

class MenuCategory {
  final String id;
  final String name;
  final String description;
  final bool isActive;

  MenuCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.isActive,
  });

  factory MenuCategory.fromJson(Map<String, dynamic> json) {
    return MenuCategory(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'isActive': isActive,
    };
  }
}
