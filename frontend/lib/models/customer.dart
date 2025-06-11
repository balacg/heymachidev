// lib/models/customer.dart

class Customer {
  final int      id;
  final String   name;
  final String   phone;   
  final String?  email;    // ← nullable
  final String?  gst;      // ← nullable
  final String?  address;  // ← nullable

  Customer({
    required this.id,
    required this.name,
    required this.phone,
    this.email,             // optional
    this.gst,               // optional
    this.address,           // optional
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id:      json['id'] as int,
        name:    json['name'] as String,
        phone:   json['phone'] as String,
        email:   json['email'] as String?,       // may be null
        gst:     json['gst'] as String?,  // matches backend field
        address: json['address'] as String?,     // may be null
      );

  Map<String, dynamic> toJson() => {
        'name':       name,
        'phone':      phone,
        'email':      email,
        'gst':        gst,
        'address':    address,
      };
}
