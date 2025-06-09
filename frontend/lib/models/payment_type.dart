class PaymentType {
  final String id;
  final String name;

  PaymentType({required this.id, required this.name});

  factory PaymentType.fromJson(Map<String, dynamic> json) {
    return PaymentType(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
