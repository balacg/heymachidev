// lib/services/restaurant/menu_category_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/restaurant/menu_category.dart';

class MenuCategoryService {
  static const String baseUrl = 'http://localhost:8000';

  static Future<List<MenuCategory>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/restaurant/menu-categories'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => MenuCategory.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch categories');
    }
  }

  static Future<bool> createCategory(MenuCategory category) async {
    final response = await http.post(
      Uri.parse('$baseUrl/restaurant/menu-categories'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(category.toJson()),
    );
    return response.statusCode == 200 || response.statusCode == 201;
  }

  static Future<bool> updateCategory(MenuCategory category) async {
    final response = await http.put(
      Uri.parse('$baseUrl/restaurant/menu-categories/${category.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(category.toJson()),
    );
    return response.statusCode == 200;
  }

  static Future<bool> deleteCategory(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/restaurant/menu-categories/$id'),
    );
    return response.statusCode == 200;
  }
}
