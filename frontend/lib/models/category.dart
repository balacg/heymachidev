// lib/models/category.dart

class Category {
  final String id;
  final String name;
  final int? gstId;

  Category({
    required this.id,
    required this.name,
    required this.gstId,
  });

  /// Construct a Category from JSON returned by the API
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'] as String,
      gstId: json['gst_id'] != null ? json['gst_id'] as int : null,
    );
  }

  /// Convert this Category into a JSON-compatible map (for POST/PUT)
  Map<String, dynamic> toJson() {
    return {
      'name':   name,
      'gst_id': gstId,               // send gst_id
    };
  }
}
