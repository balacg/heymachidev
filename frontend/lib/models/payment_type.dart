// lib/models/payment_type.dart

class PaymentType {
  final int id;
  final String name;

  PaymentType({
    required this.id,
    required this.name,
  });

  factory PaymentType.fromJson(Map<String, dynamic> json) {
    return PaymentType(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
