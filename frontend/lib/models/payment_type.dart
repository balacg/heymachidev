// lib/models/payment_type.dart

class PaymentType {
  final int? id;
  final String name;
  final String? description;

  PaymentType({this.id, required this.name, this.description});

  factory PaymentType.fromJson(Map<String, dynamic> json) {
    return PaymentType(
      id: json['id'] as int?,
      name: json['name'] ?? '',
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
      };
}
