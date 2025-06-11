// lib/models/unit.dart

class Unit {
  final int id;
  final String name;
  final String? abbreviation;

  Unit({
    required this.id,
    required this.name,
    this.abbreviation,
  });

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      id: json['id'] as int,
      name: json['name'] as String,
      abbreviation: json['abbreviation'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'abbreviation': abbreviation,
    };
  }
}
