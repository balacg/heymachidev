// lib/models/restaurant/table_layout.dart

class TableLayout {
  final String id;
  final String name;
  final String type; // e.g., "2-Seater", "4-Seater"
  final int positionX;
  final int positionY;
  final bool isActive;

  TableLayout({
    required this.id,
    required this.name,
    required this.type,
    required this.positionX,
    required this.positionY,
    required this.isActive,
  });

  factory TableLayout.fromJson(Map<String, dynamic> json) {
    return TableLayout(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      positionX: json['positionX'],
      positionY: json['positionY'],
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'positionX': positionX,
      'positionY': positionY,
      'isActive': isActive,
    };
  }
}
