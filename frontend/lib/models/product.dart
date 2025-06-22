// lib/models/product.dart

import 'package:heymachi_dev/models/tag.dart';

class Product {
  final String id;
  final String name;
  final double price;
  final String? categoryId;
  final String? subcategoryId;
  final int? gstId;
  final int? unitId;
  final bool? isActive;
  final List<int>? tagIds;
  final String? businessId;

  final String categoryName;
  final String? subcategoryName;
  final List<Tag>? tags;
  
  
  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.categoryName,
    this.categoryId,
    this.subcategoryId,
    this.gstId,
    this.subcategoryName,
    this.tagIds,
    this.tags,
    this.unitId,
    this.isActive,
    this.businessId
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
        tagIds: json['tag_ids'] != null ? List<int>.from(json['tag_ids']) : [],
        tags: (json['tags'] as List?)?.map((e) => Tag.fromJson(e)).toList(),
        isActive: json['is_active'],
        businessId: json['business_id'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'category_id': categoryId,
        'subcategory_id': subcategoryId,
        'gst_id': gstId,
        'tag_ids': tagIds ?? [],
        'tags': tags ?? [], 
        'unit_id': unitId,
        'is_active': isActive,
        'business_id': businessId,
      };
}
        