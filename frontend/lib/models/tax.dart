// lib/models/tax.dart
class Tax {
  final int id;
  final String type;
  final double rate;

  Tax({
    required this.id,
    required this.type,
    required this.rate,
  });

  factory Tax.fromJson(Map<String, dynamic> json) {
    return Tax(
      id: json['id'] as int? ?? 0,
      type: (json['type'] ?? json['name'] ?? 'GST') as String,
      rate: (json['rate'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': type,
    'type': type,
    'rate': rate,
  };
}
