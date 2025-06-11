// lib/models/subcategory.dart

class Subcategory {
  final int id;
  final String name;
  final int categoryId;
  final int gstId;

  Subcategory({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.gstId,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    return Subcategory(
      id:         json['id'] as int,
      name:       json['name'] as String,
      categoryId: json['category_id'] as int,
      gstId:      json['gst_id'] as int,   // read gst_id
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name':        name,
      'category_id': categoryId,
      'gst_id':      gstId,              // send gst_id
    };
  }
}
