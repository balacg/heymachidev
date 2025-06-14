// lib/models/restaurant/menu_item.dart

class MenuItem {
  final String id;
  final String name;
  final String? description;
  final double price;
  final String? category;

  MenuItem({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    this.category,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      price: (json['price'] ?? 0).toDouble(),
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'category': category,
      };

  MenuItem copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? category,
  }) {
    return MenuItem(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      category: category ?? this.category,
    );
  }
}
