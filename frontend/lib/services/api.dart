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
import '../models/unit.dart';
import '../models/vendor.dart';

class ApiService {
  static String get _baseHost => Platform.isAndroid ? '10.0.2.2' : 'localhost';
  static String get baseUrl   => 'http://$_baseHost:8000';
  static String? _token;
  static Map<String, dynamic>? currentUser;

  static final Map<String, String> _jsonHeaders = {
    'Content-Type': 'application/json',
  };

  // ─── CUSTOMERS (/customers/) ───────────────────────────────────────────────

  static Future<List<Customer>> fetchCustomers() async {
    final uri  = Uri.parse('$baseUrl/customers/');
    final resp = await http.get(uri, headers: headers);
    if (resp.statusCode == 200) {
      final List data = jsonDecode(resp.body);
      return data.map((e) => Customer.fromJson(e)).toList();
    }
    throw Exception('fetchCustomers ${resp.statusCode}: ${resp.body}');
  }

  static Future<Customer> addCustomer(Customer c) async {
    final uri  = Uri.parse('$baseUrl/customers/');
    final resp = await http.post(uri,
      headers: headers,
      body: jsonEncode(c.toJson()),
    );
    if (resp.statusCode == 200 || resp.statusCode == 201) {
      return Customer.fromJson(jsonDecode(resp.body));
    }
    throw Exception('addCustomer ${resp.statusCode}: ${resp.body}');
  }

  static Future<Customer> updateCustomer(Customer c) async {
    final uri  = Uri.parse('$baseUrl/customers/${c.id}');
    final resp = await http.put(uri,
      headers: headers,
      body: jsonEncode(c.toJson()),
    );
    if (resp.statusCode == 200) {
      return Customer.fromJson(jsonDecode(resp.body));
    }
    throw Exception('updateCustomer ${resp.statusCode}: ${resp.body}');
  }

  static Future<void> deleteCustomer(int id) async {
    final uri  = Uri.parse('$baseUrl/customers/$id');
    final resp = await http.delete(uri);
    if (resp.statusCode != 204) {
      throw Exception('deleteCustomer ${resp.statusCode}: ${resp.body}');
    }
  }

  // ─── PRODUCTS (/products/) ───────────────────────────────────────────────────

  static Future<List<Product>> fetchProducts() async {
    final uri  = Uri.parse('$baseUrl/products/');
    final resp = await http.get(uri, headers: headers);
    if (resp.statusCode == 200) {
      final List data = jsonDecode(resp.body);
      return data.map((e) => Product.fromJson(e)).toList();
    }
    throw Exception('fetchProducts ${resp.statusCode}: ${resp.body}');
  }

  static Future<Product> createProduct(Product p) async {
    final uri  = Uri.parse('$baseUrl/products/');
    final resp = await http.post(uri,
      headers: headers,
      body: jsonEncode(p.toJson()),
    );
    if (resp.statusCode == 200 || resp.statusCode == 201) {
      return Product.fromJson(jsonDecode(resp.body));
    }
    throw Exception('createProduct ${resp.statusCode}: ${resp.body}');
  }

  static Future<Product> updateProduct(Product p) async {
    final uri  = Uri.parse('$baseUrl/products/${p.id}');
    final resp = await http.put(uri,
      headers: headers,
      body: jsonEncode(p.toJson()),
    );
    if (resp.statusCode == 200) {
      return Product.fromJson(jsonDecode(resp.body));
    }
    throw Exception('updateProduct ${resp.statusCode}: ${resp.body}');
  }

  static Future<void> deleteProduct(String id) async {
    final uri  = Uri.parse('$baseUrl/products/$id');
    final resp = await http.delete(uri);
    if (resp.statusCode != 204 && resp.statusCode != 200) {
      throw Exception('deleteProduct ${resp.statusCode}: ${resp.body}');
    }
  }

  // ─── CATEGORIES (/categories/) ───────────────────────────────────────────────

  static Future<List<Category>> fetchCategories() async {
    final uri  = Uri.parse('$baseUrl/categories/');
    final resp = await http.get(uri, headers: headers);
    if (resp.statusCode == 200) {
      final List data = jsonDecode(resp.body);
      return data.map((e) => Category.fromJson(e)).toList();
    }
    throw Exception('fetchCategories ${resp.statusCode}: ${resp.body}');
  }

  static Future<Category> createCategory(Category c) async {
    final uri  = Uri.parse('$baseUrl/categories/');
    final resp = await http.post(uri,
      headers: headers,
      body: jsonEncode(c.toJson()),
    );
    if (resp.statusCode == 200 || resp.statusCode == 201) {
      return Category.fromJson(jsonDecode(resp.body));
    }
    throw Exception('createCategory ${resp.statusCode}: ${resp.body}');
  }

  static Future<Category> updateCategory(Category c) async {
    final uri  = Uri.parse('$baseUrl/categories/${c.id}');
    final resp = await http.put(uri,
      headers: headers,
      body: jsonEncode(c.toJson()),
    );
    if (resp.statusCode == 200) {
      return Category.fromJson(jsonDecode(resp.body));
    }
    throw Exception('updateCategory ${resp.statusCode}: ${resp.body}');
  }

  static Future<void> deleteCategory(String id) async {
    final uri  = Uri.parse('$baseUrl/categories/$id');
    final resp = await http.delete(uri);
    if (resp.statusCode != 204) {
      throw Exception('deleteCategory ${resp.statusCode}: ${resp.body}');
    }
  }

  // ─── SUBCATEGORIES (/subcategories/) ────────────────────────────────────────

  static Future<List<Subcategory>> fetchSubcategories({String? categoryId}) async {
    final path = categoryId != null
        ? '/subcategories/?category_id=$categoryId'
        : '/subcategories/';
    final uri  = Uri.parse('$baseUrl$path');
    final resp = await http.get(uri, headers: headers);
    if (resp.statusCode == 200) {
      final List data = jsonDecode(resp.body);
      return data.map((e) => Subcategory.fromJson(e)).toList();
    }
    throw Exception('fetchSubcategories ${resp.statusCode}: ${resp.body}');
  }

  static Future<Subcategory> createSubcategory(Subcategory s) async {
    final uri  = Uri.parse('$baseUrl/subcategories/');
    final resp = await http.post(uri,
      headers: headers,
      body: jsonEncode(s.toJson()),
    );
    if (resp.statusCode == 200 || resp.statusCode == 201) {
      return Subcategory.fromJson(jsonDecode(resp.body));
    }
    throw Exception('createSubcategory ${resp.statusCode}: ${resp.body}');
  }

  static Future<Subcategory> updateSubcategory(Subcategory s) async {
    final uri  = Uri.parse('$baseUrl/subcategories/${s.id}');
    final resp = await http.put(uri,
      headers: headers,
      body: jsonEncode(s.toJson()),
    );
    if (resp.statusCode == 200) {
      return Subcategory.fromJson(jsonDecode(resp.body));
    }
    throw Exception('updateSubcategory ${resp.statusCode}: ${resp.body}');
  }

  static Future<void> deleteSubcategory(String id) async {
    final uri  = Uri.parse('$baseUrl/subcategories/$id');
    final resp = await http.delete(uri);
    if (resp.statusCode != 204) {
      throw Exception('deleteSubcategory ${resp.statusCode}: ${resp.body}');
    }
  }

  // ─── PAYMENT TYPES (/payment_types/) ────────────────────────────────────

  static Future<List<PaymentType>> fetchPaymentTypes() async {
    final uri  = Uri.parse('$baseUrl/payment_types/');
    final resp = await http.get(uri, headers: headers);
    if (resp.statusCode == 200) {
      final List data = jsonDecode(resp.body);
      return data.map((e) => PaymentType.fromJson(e)).toList();
    }
    throw Exception('fetchPaymentTypes ${resp.statusCode}: ${resp.body}');
  }

  static Future<PaymentType> createPaymentType(PaymentType pt) async {
    final uri  = Uri.parse('$baseUrl/payment_types/');
    final resp = await http.post(uri,
      headers: headers,
      body: jsonEncode(pt.toJson()),
    );
    if (resp.statusCode == 200 || resp.statusCode == 201) {
      return PaymentType.fromJson(jsonDecode(resp.body));
    }
    throw Exception('createPaymentType ${resp.statusCode}: ${resp.body}');
  }

  static Future<PaymentType> updatePaymentType(PaymentType pt) async {
    final uri  = Uri.parse('$baseUrl/payment_types/${pt.id}');
    final resp = await http.put(uri,
      headers: headers,
      body: jsonEncode(pt.toJson()),
    );
    if (resp.statusCode == 200) {
      return PaymentType.fromJson(jsonDecode(resp.body));
    }
    throw Exception('updatePaymentType ${resp.statusCode}: ${resp.body}');
  }

  static Future<void> deletePaymentType(int id) async {
    final uri  = Uri.parse('$baseUrl/payment_types/$id');
    final resp = await http.delete(uri);
    if (resp.statusCode != 204) {
      throw Exception('deletePaymentType ${resp.statusCode}: ${resp.body}');
    }
  }

  // ─── TAXES (/taxes/) ─────────────────────────────────────────────────────────

  static Future<List<Tax>> fetchTaxes() async {
    final uri  = Uri.parse('$baseUrl/taxes/');
    final resp = await http.get(uri, headers: headers);
    if (resp.statusCode == 200) {
      final List data = jsonDecode(resp.body);
      return data.map((e) => Tax.fromJson(e)).toList();
    }
    throw Exception('fetchTaxes ${resp.statusCode}: ${resp.body}');
  }

  static Future<Tax> createTax(Tax t) async {
    final uri  = Uri.parse('$baseUrl/taxes/');
    final resp = await http.post(uri,
      headers: headers,
      body: jsonEncode(t.toJson()),
    );
    if (resp.statusCode == 200 || resp.statusCode == 201) {
      return Tax.fromJson(jsonDecode(resp.body));
    }
    throw Exception('createTax ${resp.statusCode}: ${resp.body}');
  }

  static Future<Tax> updateTax(Tax t) async {
    final uri  = Uri.parse('$baseUrl/taxes/${t.id}/');
    final resp = await http.put(uri,
      headers: headers,
      body: jsonEncode(t.toJson()),
    );
    if (resp.statusCode == 200) {
      return Tax.fromJson(jsonDecode(resp.body));
    }
    throw Exception('updateTax ${resp.statusCode}: ${resp.body}');
  }

  static Future<void> deleteTax(int id) async {
    final uri  = Uri.parse('$baseUrl/taxes/$id/');
    final resp = await http.delete(uri);
    if (resp.statusCode != 204) {
      throw Exception('deleteTax ${resp.statusCode}: ${resp.body}');
    }
  }

  // ─── VENDORS (/vendor/) ────────────────────────────────────────────────────

  static Future<List<Vendor>> fetchVendors() async {
    final uri  = Uri.parse('$baseUrl/vendors/');
    final resp = await http.get(uri, headers: headers);
    if (resp.statusCode == 200) {
      final List data = jsonDecode(resp.body);
      return data.map((e) => Vendor.fromJson(e)).toList();
    }
    throw Exception('fetchVendors ${resp.statusCode}: ${resp.body}');
  }

  static Future<Vendor> createVendor(Vendor v) async {
    final uri  = Uri.parse('$baseUrl/vendors/');
    final resp = await http.post(uri,
      headers: headers,
      body: jsonEncode(v.toJson()),
    );
    if (resp.statusCode == 200 || resp.statusCode == 201) {
      return Vendor.fromJson(jsonDecode(resp.body));
    }
    throw Exception('createVendor ${resp.statusCode}: ${resp.body}');
  }

  static Future<Vendor> updateVendor(Vendor v) async {
    final uri  = Uri.parse('$baseUrl/vendors/${v.id}');
    final resp = await http.put(uri,
      headers: headers,
      body: jsonEncode(v.toJson()),
    );
    if (resp.statusCode == 200) {
      return Vendor.fromJson(jsonDecode(resp.body));
    }
    throw Exception('updateVendor ${resp.statusCode}: ${resp.body}');
  }

  static Future<void> deleteVendor(int id) async {
    final uri  = Uri.parse('$baseUrl/vendors/$id');
    final resp = await http.delete(uri);
    if (resp.statusCode != 204) {
      throw Exception('deleteVendor ${resp.statusCode}: ${resp.body}');
    }
  }

  // ─── UNITS (/unit/) ────────────────────────────────────────────────────────

  static Future<List<Unit>> fetchUnits() async {
    final uri  = Uri.parse('$baseUrl/units/');
    final resp = await http.get(uri, headers: headers);
    if (resp.statusCode == 200) {
      final List data = jsonDecode(resp.body);
      return data.map((e) => Unit.fromJson(e)).toList();
    }
    throw Exception('fetchUnits ${resp.statusCode}: ${resp.body}');
  }

  static Future<Unit> createUnit(Unit u) async {
    final uri  = Uri.parse('$baseUrl/units/');
    final resp = await http.post(uri,
      headers: headers,
      body: jsonEncode(u.toJson()),
    );
    if (resp.statusCode == 200 || resp.statusCode == 201) {
      return Unit.fromJson(jsonDecode(resp.body));
    }
    throw Exception('createUnit ${resp.statusCode}: ${resp.body}');
  }

  static Future<Unit> updateUnit(Unit u) async {
    final uri  = Uri.parse('$baseUrl/units/${u.id}');
    final resp = await http.put(uri,
      headers: headers,
      body: jsonEncode(u.toJson()),
    );
    if (resp.statusCode == 200) {
      return Unit.fromJson(jsonDecode(resp.body));
    }
    throw Exception('updateUnit ${resp.statusCode}: ${resp.body}');
  }

  static Future<void> deleteUnit(int id) async {
    final uri  = Uri.parse('$baseUrl/units/$id');
    final resp = await http.delete(uri);
    if (resp.statusCode != 204) {
      throw Exception('deleteUnit ${resp.statusCode}: ${resp.body}');
    }
  }

  // ─── TRANSACTIONS (/transactions/) ────────────────────────────────────────────────────────
  static Future<void> postTransaction(Map<String, dynamic> data) async {
    final uri = Uri.parse('$baseUrl/transactions/');
    final resp = await http.post(uri,
      headers: headers,
      body: jsonEncode(data),
    );
    if (resp.statusCode != 200 && resp.statusCode != 201) {
      throw Exception('postTransaction ${resp.statusCode}: ${resp.body}');
    }
  }

  static Future<List<Map<String, dynamic>>> fetchTransactionItemsForCustomer(String customerName) async {
    final response = await http.get(Uri.parse('$baseUrl/transactions'), headers: headers);
    if (response.statusCode != 200) throw Exception("Failed to fetch transactions");
    final data = jsonDecode(response.body) as List;
    return data.where((item) => item['customer_name'] == customerName).toList().cast<Map<String, dynamic>>();
  }

  static Future<Map<String, dynamic>> fetchBusinessProfile() async {
    final uri = Uri.parse('$baseUrl/business-profile/');
    final resp = await http.get(uri, headers: headers);
    if (resp.statusCode == 200) {
      return jsonDecode(resp.body);
    }
    throw Exception('fetchBusinessProfile ${resp.statusCode}: ${resp.body}');
  }

  static Future<List<Map<String, dynamic>>> fetchIndustries() async {
    final uri = Uri.parse('$baseUrl/industries');
  final resp = await http.get(uri, headers: headers);
    if (resp.statusCode == 200) {
      final List data = jsonDecode(resp.body);
      return data.cast<Map<String, dynamic>>();
    }
    throw Exception('fetchIndustries ${resp.statusCode}: ${resp.body}');
  }

  static Future<dynamic> get(String endpoint) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final resp = await http.get(uri, headers: headers);
    if (resp.statusCode == 200) {
      return jsonDecode(resp.body);
    }
    throw Exception('GET $endpoint failed: ${resp.statusCode} ${resp.body}');
  }

  static Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final resp = await http.post(uri,
      headers: headers,
      body: jsonEncode(data),
    );
    if (resp.statusCode == 200 || resp.statusCode == 201) {
      return jsonDecode(resp.body);
    }
    throw Exception('POST $endpoint failed: ${resp.statusCode} ${resp.body}');
  }

  // ─── SECURITY (/security/) ────────────────────────────────────────────────────────

  static Future<void> setToken(String token) async {
    _token = token;
  }

  static Map<String, String> get headers => {
    'Authorization': 'Bearer $_token',
    'Content-Type': 'application/json',
  };

  static Future<void> fetchUserSession() async {
    final response = await http.get(
      Uri.parse('$baseUrl/auth/me'),
      headers: headers,
    );


    if (response.statusCode == 200) {
      currentUser = json.decode(response.body);
    } else {
      throw Exception("Failed to fetch user session");
    }
  }

  static Future<String> fetchBranchState() async {
  final res = await http.get(Uri.parse('$baseUrl/branches/default'));
  if (res.statusCode == 200) {
    final data = jsonDecode(res.body);
    return data['state'] ?? 'Tamil Nadu'; // fallback to old logic
  } else {
    throw Exception("Branch info not found");
  }
}
}

