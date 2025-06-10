// lib/models/tax.dart

class Tax {
  final int id;
  final String type;   // e.g. “GST” or “VAT”
  final double rate;   // percent value, e.g. 18.0

  Tax({
    required this.id,
    required this.type,
    required this.rate,
  });

  factory Tax.fromJson(Map<String, dynamic> json) {
    return Tax(
      id: json['id'] as int? ?? 0,
      // read from the backend's 'name' field
      type: json['name'] as String? ?? '',
      rate: (json['rate'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
        // send it back under 'name'
        'name': type,
        'rate': rate,
      };
}
