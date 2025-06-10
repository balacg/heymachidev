// lib/models/subcategory.dart

class Subcategory {
  final int id;
  final String name;
  final int categoryId;

  Subcategory({
    required this.id,
    required this.name,
    required this.categoryId,
  });

  /// Construct a Subcategory from JSON returned by the API
  factory Subcategory.fromJson(Map<String, dynamic> json) {
    return Subcategory(
      id: json['id'] as int,
      name: json['name'] as String,
      categoryId: json['category_id'] as int,
    );
  }

  /// Convert this Subcategory into a JSON-compatible map (for POST/PUT)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category_id': categoryId,
    };
  }
}
