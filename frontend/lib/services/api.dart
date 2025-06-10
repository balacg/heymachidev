// lib/services/api.dart

import 'dart:convert';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;

import '../models/customer.dart';
import '../models/category.dart';
import '../models/subcategory.dart';
import '../models/payment_type.dart';
import '../models/tax.dart';
import '../models/product.dart';

class ApiService {
  static String get _baseHost => Platform.isAndroid ? '10.0.2.2' : 'localhost';
  static String get baseUrl   => 'http://$_baseHost:8000';

  // ─── CUSTOMERS ────────────────────────────────────────────────────────────

  /// Fetch all customers
  static Future<List<Customer>> fetchCustomers() async {
    final uri  = Uri.parse('$baseUrl/customers/');
    final resp = await http.get(uri);
    if (resp.statusCode == 200) {
      final List data = jsonDecode(resp.body);
      return data.map((e) => Customer.fromJson(e)).toList();
    }
    throw Exception('fetchCustomers: ${resp.statusCode}');
  }

  /// Create a new customer
  static Future<Customer> addCustomer(Customer c) async {
    final uri  = Uri.parse('$baseUrl/customers/');
    final resp = await http.post(uri,
      headers: {'Content-Type':'application/json'},
      body: jsonEncode(c.toJson()),
    );
    if (resp.statusCode == 200 || resp.statusCode == 201) {
      return Customer.fromJson(jsonDecode(resp.body));
    }
    throw Exception('addCustomer: ${resp.statusCode}');
  }

  /// Update an existing customer
  static Future<Customer> updateCustomer(Customer c) async {
    final uri  = Uri.parse('$baseUrl/customers/${c.id}');
    final resp = await http.put(uri,
      headers: {'Content-Type':'application/json'},
      body: jsonEncode(c.toJson()),
    );
    if (resp.statusCode == 200) {
      return Customer.fromJson(jsonDecode(resp.body));
    }
    throw Exception('updateCustomer: ${resp.statusCode}');
  }

  /// Delete a customer by ID
  static Future<void> deleteCustomer(int id) async {
    final uri  = Uri.parse('$baseUrl/customers/$id');
    final resp = await http.delete(uri);
    if (resp.statusCode != 200 && resp.statusCode != 204) {
      throw Exception('deleteCustomer: ${resp.statusCode}');
    }
  }

  // ─── PRODUCTS ──────────────────────────────────────────────────────────────

  /// Fetch all products
  static Future<List<Product>> fetchProducts() async {
    final uri  = Uri.parse('$baseUrl/products/');
    final resp = await http.get(uri);
    if (resp.statusCode == 200) {
      final List data = jsonDecode(resp.body);
      return data.map((e) => Product.fromJson(e)).toList();
    }
    throw Exception('fetchProducts: ${resp.statusCode}');
  }

  /// Create a new product
  static Future<Product> createProduct(Product p) async {
    final uri  = Uri.parse('$baseUrl/products/');
    final resp = await http.post(uri,
      headers: {'Content-Type':'application/json'},
      body: jsonEncode(p.toJson()),
    );
    if (resp.statusCode == 200 || resp.statusCode == 201) {
      return Product.fromJson(jsonDecode(resp.body));
    }
    throw Exception('createProduct: ${resp.statusCode}');
  }

  /// Update an existing product
  static Future<Product> updateProduct(Product p) async {
    final uri  = Uri.parse('$baseUrl/products/${p.id}');
    final resp = await http.put(uri,
      headers: {'Content-Type':'application/json'},
      body: jsonEncode(p.toJson()),
    );
    if (resp.statusCode == 200) {
      return Product.fromJson(jsonDecode(resp.body));
    }
    throw Exception('updateProduct: ${resp.statusCode}');
  }

  /// Delete a product by ID
  static Future<void> deleteProduct(int id) async {
    final uri  = Uri.parse('$baseUrl/products/$id');
    final resp = await http.delete(uri);
    if (resp.statusCode != 200 && resp.statusCode != 204) {
      throw Exception('deleteProduct: ${resp.statusCode}');
    }
  }

  // ─── CATEGORIES ────────────────────────────────────────────────────────────

  static Future<List<Category>> fetchCategories() async {
    final uri  = Uri.parse('$baseUrl/categories/');
    final resp = await http.get(uri);
    if (resp.statusCode == 200) {
      final List data = jsonDecode(resp.body);
      return data.map((e) => Category.fromJson(e)).toList();
    }
    throw Exception('fetchCategories: ${resp.statusCode}');
  }

  static Future<Category> createCategory(Category c) async {
    final uri  = Uri.parse('$baseUrl/categories/');
    final resp = await http.post(uri,
      headers: {'Content-Type':'application/json'},
      body: jsonEncode({'name': c.name}),
    );
    if (resp.statusCode == 200 || resp.statusCode == 201) {
      return Category.fromJson(jsonDecode(resp.body));
    }
    throw Exception('createCategory: ${resp.statusCode}');
  }

  static Future<Category> updateCategory(Category c) async {
    final uri  = Uri.parse('$baseUrl/categories/${c.id}/');
    final resp = await http.put(uri,
      headers: {'Content-Type':'application/json'},
      body: jsonEncode({'name': c.name}),
    );
    if (resp.statusCode == 200) {
      return Category.fromJson(jsonDecode(resp.body));
    }
    throw Exception('updateCategory: ${resp.statusCode}');
  }

  static Future<void> deleteCategory(int id) async {
    final uri  = Uri.parse('$baseUrl/categories/$id/');
    final resp = await http.delete(uri);
    if (resp.statusCode != 200 && resp.statusCode != 204) {
      throw Exception('deleteCategory: ${resp.statusCode}');
    }
  }

  // ─── SUBCATEGORIES ─────────────────────────────────────────────────────────

  static Future<List<Subcategory>> fetchSubcategories({int? categoryId}) async {
    final path = categoryId != null
        ? '/subcategories/?category_id=$categoryId'
        : '/subcategories/';
    final uri  = Uri.parse('$baseUrl$path');
    final resp = await http.get(uri);
    if (resp.statusCode == 200) {
      final List data = jsonDecode(resp.body);
      return data.map((e) => Subcategory.fromJson(e)).toList();
    }
    throw Exception('fetchSubcategories: ${resp.statusCode}');
  }

  static Future<Subcategory> createSubcategory(Subcategory s) async {
    final uri  = Uri.parse('$baseUrl/subcategories/');
    final resp = await http.post(uri,
      headers: {'Content-Type':'application/json'},
      body: jsonEncode({
        'name': s.name,
        'category_id': s.categoryId,
      }),
    );
    if (resp.statusCode == 200 || resp.statusCode == 201) {
      return Subcategory.fromJson(jsonDecode(resp.body));
    }
    throw Exception('createSubcategory: ${resp.statusCode}');
  }

  static Future<Subcategory> updateSubcategory(Subcategory s) async {
    final uri  = Uri.parse('$baseUrl/subcategories/${s.id}/');
    final resp = await http.put(uri,
      headers: {'Content-Type':'application/json'},
      body: jsonEncode({'name': s.name}),
    );
    if (resp.statusCode == 200) {
      return Subcategory.fromJson(jsonDecode(resp.body));
    }
    throw Exception('updateSubcategory: ${resp.statusCode}');
  }

  static Future<void> deleteSubcategory(int id) async {
    final uri  = Uri.parse('$baseUrl/subcategories/$id/');
    final resp = await http.delete(uri);
    if (resp.statusCode != 200 && resp.statusCode != 204) {
      throw Exception('deleteSubcategory: ${resp.statusCode}');
    }
  }

  // ─── PAYMENT TYPES ─────────────────────────────────────────────────────────

  static Future<List<PaymentType>> fetchPaymentTypes() async {
    final uri  = Uri.parse('$baseUrl/payment_types/');
    final resp = await http.get(uri);
    if (resp.statusCode == 200) {
      final List data = jsonDecode(resp.body);
      return data.map((e) => PaymentType.fromJson(e)).toList();
    }
    throw Exception('fetchPaymentTypes: ${resp.statusCode}');
  }

  static Future<PaymentType> createPaymentType(PaymentType pt) async {
    final uri  = Uri.parse('$baseUrl/payment_types/');
    final resp = await http.post(uri,
      headers: {'Content-Type':'application/json'},
      body: jsonEncode(pt.toJson()),
    );
    if (resp.statusCode == 200 || resp.statusCode == 201) {
      return PaymentType.fromJson(jsonDecode(resp.body));
    }
    throw Exception('createPaymentType: ${resp.statusCode}');
  }

  static Future<PaymentType> updatePaymentType(PaymentType pt) async {
    final uri  = Uri.parse('$baseUrl/payment_types/${pt.id}/');
    final resp = await http.put(uri,
      headers: {'Content-Type':'application/json'},
      body: jsonEncode(pt.toJson()),
    );
    if (resp.statusCode == 200) {
      return PaymentType.fromJson(jsonDecode(resp.body));
    }
    throw Exception('updatePaymentType: ${resp.statusCode}');
  }

  static Future<void> deletePaymentType(int id) async {
    final uri  = Uri.parse('$baseUrl/payment_types/$id/');
    final resp = await http.delete(uri);
    if (resp.statusCode != 200 && resp.statusCode != 204) {
      throw Exception('deletePaymentType: ${resp.statusCode}');
    }
  }

  // ─── TAXES ────────────────────────────────────────────────────────────────

  static Future<List<Tax>> fetchTaxes() async {
    final uri  = Uri.parse('$baseUrl/taxes/');
    final resp = await http.get(uri);
    if (resp.statusCode == 200) {
      final List data = jsonDecode(resp.body);
      return data.map((e) => Tax.fromJson(e)).toList();
    }
    throw Exception('fetchTaxes: ${resp.statusCode}');
  }

  static Future<Tax> createTax(Tax t) async {
    final uri  = Uri.parse('$baseUrl/taxes/');
    final resp = await http.post(uri,
      headers: {'Content-Type':'application/json'},
      body: jsonEncode(t.toJson()),
    );
    if (resp.statusCode == 200 || resp.statusCode == 201) {
      return Tax.fromJson(jsonDecode(resp.body));
    }
    throw Exception('createTax: ${resp.statusCode}');
  }

  static Future<Tax> updateTax(Tax t) async {
    final uri  = Uri.parse('$baseUrl/taxes/${t.id}/');
    final resp = await http.put(uri,
      headers: {'Content-Type':'application/json'},
      body: jsonEncode(t.toJson()),
    );
    if (resp.statusCode == 200) {
      return Tax.fromJson(jsonDecode(resp.body));
    }
    throw Exception('updateTax: ${resp.statusCode}');
  }

  static Future<void> deleteTax(int id) async {
    final uri  = Uri.parse('$baseUrl/taxes/$id/');
    final resp = await http.delete(uri);
    if (resp.statusCode != 200 && resp.statusCode != 204) {
      throw Exception('deleteTax: ${resp.statusCode}');
    }
  }
}
