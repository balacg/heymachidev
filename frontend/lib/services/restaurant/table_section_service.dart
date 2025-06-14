// lib/services/restaurant/table_section_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/restaurant/table_section.dart';

class TableSectionService {
  static const String baseUrl = 'http://localhost:8000';

  static Future<List<TableSection>> fetchSections() async {
    final response = await http.get(Uri.parse('$baseUrl/restaurant/table-sections'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => TableSection.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch sections');
    }
  }

  static Future<bool> createSection(TableSection section) async {
    final response = await http.post(
      Uri.parse('$baseUrl/restaurant/table-sections'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(section.toJson()),
    );
    return response.statusCode == 200 || response.statusCode == 201;
  }

  static Future<bool> updateSection(TableSection section) async {
    final response = await http.put(
      Uri.parse('$baseUrl/restaurant/table-sections/${section.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(section.toJson()),
    );
    return response.statusCode == 200;
  }

  static Future<bool> deleteSection(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/restaurant/table-sections/$id'),
    );
    return response.statusCode == 200;
  }
}
