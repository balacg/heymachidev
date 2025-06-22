// lib/services/tag_service.dart

import 'dart:convert';
import 'package:heymachi_dev/utils/app_session.dart';
import 'package:http/http.dart' as http;
import '../models/tag.dart';

class TagService {
  static const String baseUrl = 'http://localhost:8000/tags';

  static Future<List<Tag>> fetchTags(String businessId) async {
    final uri = Uri.parse('$baseUrl/?business_id=$businessId');
    print("Bearer Token: ${AppSession.instance.sessionData['access_token']}");

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppSession.instance.sessionData['access_token']}',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Tag.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tags');
    }
  }

  static Future<Tag> createTag(Tag tag) async {
    final response = await http.post(
      Uri.parse('$baseUrl/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(tag.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Tag.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create tag');
    }
  }

  static Future<Tag> updateTag(int id, Tag tag) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(tag.toJson()),
    );

    if (response.statusCode == 200) {
      return Tag.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update tag');
    }
  }

  static Future<void> deleteTag(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete tag');
    }
  }
}
