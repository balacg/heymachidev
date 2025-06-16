// lib/services/promotion_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/promotion.dart';
import 'api.dart'; // Ensure this is imported

class PromotionService {
  static String get _baseUrl => ApiService.baseUrl;

  static Future<List<Promotion>> fetchPromotions() async {
    final response = await http.get(Uri.parse('$_baseUrl/promotions/'), headers: ApiService.headers);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Promotion.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch promotions: ${response.body}');
    }
  }

  static Future<bool> createPromotion(Promotion promo) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/promotions/'),
      headers: ApiService.headers,
      body: jsonEncode(promo.toJson()),
    );
    return response.statusCode == 200 || response.statusCode == 201;
  }

  static Future<bool> updatePromotion(Promotion promo) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/promotions/${promo.id}'),
      headers: ApiService.headers,
      body: jsonEncode(promo.toJson()),
    );
    return response.statusCode == 200;
  }

  static Future<void> deletePromotion(String id) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/promotions/$id'),
      headers: ApiService.headers,
    );
    if (response.statusCode != 204) {
      throw Exception('Delete failed: ${response.body}');
    }
  }
}
