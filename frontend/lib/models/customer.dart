// lib/models/customer.dart

class Customer {
  final int      id;
  final String   name;
  final String   phone;   
  final String?  email;    // ← nullable
  final String?  gst;      // ← nullable
  final String?  address;  // ← nullable
  final String? state;

  Customer({
    required this.id,
    required this.name,
    required this.phone,
    this.email,             // optional
    this.gst,               // optional
    this.address,           // optional
    this.state
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id:      json['id'] as int,
        name:    json['name'] as String,
        phone:   json['phone'] as String,
        email:   json['email'] as String?,       // may be null
        gst:     json['gst'] as String?,  // matches backend field
        address: json['address'] as String?,     // may be null
        state:   json['state'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'name':       name,
        'phone':      phone,
        'email':      email,
        'gst':        gst,
        'address':    address,
        'state':      state,
      };
}
