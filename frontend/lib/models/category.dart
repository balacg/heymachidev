// lib/models/category.dart

class Category {
  final int id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  /// Construct a Category from JSON returned by the API
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  /// Convert this Category into a JSON-compatible map (for POST/PUT)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
