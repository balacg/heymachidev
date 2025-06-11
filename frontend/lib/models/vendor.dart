// lib/models/vendor.dart

class Vendor {
  final int id;
  final String name;
  final String phone;
  final String? email;
  final String? gst;
  final String? address;

  Vendor({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
    this.gst,
    this.address,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json['id'] as int,
      name: json['name'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String?,
      gst: json['gst'] as String?,
      address: json['address'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'gst': gst,
      'address': address,
    };
  }
}
