// lib/models/restaurant/table.dart

class RestaurantTable {
  final String? id;
  final String name;
  final int capacity;

  RestaurantTable({
    this.id,
    required this.name,
    required this.capacity,
  });

  factory RestaurantTable.fromJson(Map<String, dynamic> json) {
    return RestaurantTable(
      id: json['id'],
      name: json['name'],
      capacity: json['capacity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'capacity': capacity,
    };
  }
}
