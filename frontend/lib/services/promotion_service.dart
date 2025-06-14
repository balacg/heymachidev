// lib/services/promotion_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/promotion.dart';

class PromotionService {
  static const String baseUrl = 'http://localhost:8000';

  static Future<List<Promotion>> fetchPromotions() async {
    final response = await http.get(Uri.parse('$baseUrl/promotions'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Promotion.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch promotions');
    }
  }

  static Future<bool> createPromotion(Promotion promotion) async {
    final response = await http.post(
      Uri.parse('$baseUrl/promotions'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(promotion.toJson()),
    );
    return response.statusCode == 200 || response.statusCode == 201;
  }

  static Future<bool> deletePromotion(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/promotions/$id'));
    return response.statusCode == 200;
  }

  static Future<bool> updatePromotion(Promotion promotion) async {
    final response = await http.put(
      Uri.parse('$baseUrl/promotions/${promotion.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(promotion.toJson()),
    );
    return response.statusCode == 200;
  }
}
