// lib/models/tag.dart

class Tag {
  final int? id;
  final String tagType;
  final String tagValue;
  final String businessId;
  final bool isActive;

  Tag({
    this.id,
    required this.tagType,
    required this.tagValue,
    required this.businessId,
    this.isActive = true,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'],
      tagType: json['tag_type'],
      tagValue: json['tag_value'],
      businessId: json['business_id'],
      isActive: json['is_active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tag_type': tagType,
      'tag_value': tagValue,
      'business_id': businessId,
      'is_active': isActive,
    };
  }
}
