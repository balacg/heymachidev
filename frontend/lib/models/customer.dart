// lib/models/customer.dart

class Customer {
  final int id;
  final String name;
  final String phone;    // renamed from mobile
  final String email;
  final String gst;
  final String address;

  Customer({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.gst,
    required this.address,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id:      json['id'] as int,
        name:    json['name'] as String,
        phone:   json['phone'] as String? ?? '',
        email:   json['email'] as String? ?? '',
        gst:     json['gst'] as String? ?? '',
        address: json['address'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'name':    name,
        'phone':   phone,
        'email':   email,
        'gst':     gst,
        'address': address,
      };
}
