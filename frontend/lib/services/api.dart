// lib/services/api.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/customer.dart';

class Product {
  final int id;
  final String name;
  final double price;
  final String categoryName;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.categoryName,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      categoryName: json['category_name'],
    );
  }
}

class ApiService {
  static const String baseUrl = "http://localhost:8000";

  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products/'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<void> addCustomer(Customer customer) async {
    final url = Uri.parse('$baseUrl/customers/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(customer.toJson()),
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to add customer');
    }
  }

  static Future<List<Customer>> fetchCustomers() async {
    final response = await http.get(Uri.parse('$baseUrl/customers/'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((item) => Customer.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch customers');
    }
  }
}
