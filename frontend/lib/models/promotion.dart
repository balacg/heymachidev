// lib/models/promotion.dart

class Promotion {
  final String id;
  final String title;
  final String description;
  final double discountPercentage;
  final DateTime startDate;
  final DateTime endDate;

  Promotion({
    required this.id,
    required this.title,
    required this.description,
    required this.discountPercentage,
    required this.startDate,
    required this.endDate,
  });

  factory Promotion.fromJson(Map<String, dynamic> json) {
    return Promotion(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      discountPercentage: (json['discount_percentage'] ?? 0).toDouble(),
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'discount_percentage': discountPercentage,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
    };
  }
}
