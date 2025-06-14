// lib/services/restaurant/menu_item_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/restaurant/menu_item.dart';

class MenuItemService {
  static const String baseUrl = 'http://localhost:8000';

  static Future<List<MenuItem>> fetchItems() async {
    final response = await http.get(Uri.parse('$baseUrl/restaurant/menu-items'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => MenuItem.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch menu items');
    }
  }

  static Future<bool> createItem(MenuItem item) async {
    final response = await http.post(
      Uri.parse('$baseUrl/restaurant/menu-items'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(item.toJson()),
    );
    return response.statusCode == 200 || response.statusCode == 201;
  }

  static Future<bool> updateItem(MenuItem item) async {
    final response = await http.put(
      Uri.parse('$baseUrl/restaurant/menu-items/${item.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(item.toJson()),
    );
    return response.statusCode == 200;
  }

  static Future<bool> deleteItem(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/restaurant/menu-items/$id'),
    );
    return response.statusCode == 200;
  }
}
