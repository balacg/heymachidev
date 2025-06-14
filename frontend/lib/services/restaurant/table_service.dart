// lib/services/restaurant/table_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/restaurant/table.dart';

class TableService {
  static const String baseUrl = 'http://localhost:8000';

  static Future<List<RestaurantTable>> fetchTables() async {
    final response = await http.get(Uri.parse('$baseUrl/restaurant/tables'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => RestaurantTable.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch tables');
    }
  }

  static Future<bool> createTable(RestaurantTable table) async {
    final response = await http.post(
      Uri.parse('$baseUrl/restaurant/tables'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(table.toJson()),
    );
    return response.statusCode == 200 || response.statusCode == 201;
  }

  static Future<bool> updateTable(RestaurantTable table) async {
    final response = await http.put(
      Uri.parse('$baseUrl/restaurant/tables/${table.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(table.toJson()),
    );
    return response.statusCode == 200;
  }

  static Future<bool> deleteTable(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/restaurant/tables/$id'));
    return response.statusCode == 200;
  }
}
