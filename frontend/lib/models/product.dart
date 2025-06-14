// lib/models/product.dart

class Product {
  final int id;
  final String name;
  final double price;
  final String categoryName;
  final int? categoryId;
  final int? subcategoryId;
  final int? gstId;      // new

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.categoryName,
    this.categoryId,
    this.subcategoryId,
    this.gstId,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id:            json['id'] as int,
        name:          json['name'] as String,
        price:         (json['price'] as num).toDouble(),
        categoryName:  json['category_name'] as String,
        categoryId:    json['category_id'] as int?,
        subcategoryId: json['subcategory_id'] as int?,
        gstId: json['gst_id'] != null ? json['gst_id'] as int : null,
      );

  Map<String, dynamic> toJson() => {
        'name':           name,
        'price':          price,
        'category_id':    categoryId,
        'subcategory_id': subcategoryId,
        'gst_id':         gstId,               // include gst_id
      };
}
