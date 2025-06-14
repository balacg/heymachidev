// lib/services/restaurant/menu_subcategory_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/restaurant/menu_subcategory.dart';

class MenuSubcategoryService {
  static const String baseUrl = 'http://localhost:8000';

  static Future<List<MenuSubcategory>> fetchSubcategories() async {
    final response = await http.get(Uri.parse('$baseUrl/restaurant/menu-subcategories'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => MenuSubcategory.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch subcategories');
    }
  }

  static Future<bool> createSubcategory(MenuSubcategory subcategory) async {
    final response = await http.post(
      Uri.parse('$baseUrl/restaurant/menu-subcategories'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(subcategory.toJson()),
    );
    return response.statusCode == 200 || response.statusCode == 201;
  }

  static Future<bool> updateSubcategory(MenuSubcategory subcategory) async {
    final response = await http.put(
      Uri.parse('$baseUrl/restaurant/menu-subcategories/${subcategory.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(subcategory.toJson()),
    );
    return response.statusCode == 200;
  }

  static Future<bool> deleteSubcategory(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/restaurant/menu-subcategories/$id'),
    );
    return response.statusCode == 200;
  }
}
