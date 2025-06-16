// lib/models/subcategory.dart

class Subcategory {
  final String id;
  final String name;
  final String categoryId;
  final int? gstId;

  Subcategory({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.gstId,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    return Subcategory(
      id:         json['id'],
      name:       json['name'] as String,
      categoryId: json['category_id'],
      gstId: json['gst_id'] != null ? json['gst_id'] as int : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name':        name,
      'category_id': categoryId,
      'gst_id':      gstId,              
    };
  }
}
