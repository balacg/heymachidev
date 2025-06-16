// lib/models/vendor.dart

class Vendor {
  final int? id;
  final String name;
  final String phone;
  final String? email;
  final String? gst;
  final String? address;

  Vendor({
    this.id,
    required this.name,
    required this.phone,
    this.email,
    this.gst,
    this.address,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      gst: json['gst'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'gst': gst,
      'address': address,
    };
  }
}
