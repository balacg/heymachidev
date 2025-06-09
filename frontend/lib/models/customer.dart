// lib/models/customer.dart

class Customer {
  final int id;
  final String name;
  final String mobile;
  final String address;
  final String gst;     // Optional GST number
  final String email;   // ✅ Newly added email field

  Customer({
    required this.id,
    required this.name,
    required this.mobile,
    required this.address,
    this.gst = '',
    this.email = '', // ✅ Default to empty string
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'] ?? '',
      mobile: json['mobile'] ?? '',
      address: json['address'] ?? '',
      gst: json['gst'] ?? '',
      email: json['email'] ?? '', // ✅ Safe parsing
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'mobile': mobile,
      'address': address,
      'gst': gst,
      'email': email, // ✅ Include in API payload
    };
  }
}
