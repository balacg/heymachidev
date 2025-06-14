// lib/models/restaurant/table_section.dart

class TableSection {
  final String id;
  final String name;
  final String description;
  final bool isActive;

  TableSection({
    required this.id,
    required this.name,
    required this.description,
    required this.isActive,
  });

  factory TableSection.fromJson(Map<String, dynamic> json) {
    return TableSection(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'isActive': isActive,
    };
  }
}
