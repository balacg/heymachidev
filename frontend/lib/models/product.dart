// lib/models/product.dart

class Product {
  final String id;
  final String name;
  final double price;
  final String categoryName;
  final String? categoryId;
  final String? subcategoryId;
  final int? gstId;
  final String? subcategoryName;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.categoryName,
    this.categoryId,
    this.subcategoryId,
    this.gstId,
    this.subcategoryName,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id']?.toString() ?? '',
        name: json['name']?.toString() ?? '',
        price: (json['price'] as num?)?.toDouble() ?? 0.0,
        categoryName: json['category_name']?.toString() ?? '',
        categoryId: json['category_id']?.toString(),
        subcategoryId: json['subcategory_id']?.toString(),
        gstId: json['gst_id'] is int
            ? json['gst_id']
            : int.tryParse(json['gst_id']?.toString() ?? ''),
        subcategoryName: json['subcategory_name']?.toString(),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'category_id': categoryId,
        'subcategory_id': subcategoryId,
        'gst_id': gstId,
      };
}
