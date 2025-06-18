import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:heymachi_dev/services/api.dart';
import 'package:http/http.dart' as http;

class RestaurantApi {
  static const String baseUrl = 'http://localhost:8000'; // Update as needed

  static Future<List<dynamic>> getOpenOrders() async {
    final response = await http.get(Uri.parse('$baseUrl/open-orders/'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch open orders');
    }
  }

  static Future<void> cancelOrder(String orderId) async {
    final response = await http.delete(Uri.parse('$baseUrl/open-orders/$orderId'));
    if (response.statusCode != 200) {
      throw Exception('Failed to cancel order');
    }
  }

  static Future<void> createOrUpdateOrder(Map<String, dynamic> order) async {
    final url = '$baseUrl/open-orders/';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(order),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to save order');
    }
  }

  static Future<void> saveOpenOrder(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/open-orders/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to save open order');
      }
    } catch (e) {
      debugPrint('Error saving open order: $e');
      rethrow;
    }
  }

  static Future<int> getNextTokenSequence(String prefix) async {
    final url = Uri.parse('$baseUrl/token-sequence/next?prefix=$prefix');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['next'] ?? 1;
    } else {
      throw Exception('Failed to fetch next token sequence');
    }
  }

  static Future<Map<String, dynamic>> getToken(String typeCode) async {
    return await ApiService.get('/open-orders/generate-token/$typeCode');
  }

  static Future<String> getTokenForType(String typeCode) async {
    final response = await http.get(Uri.parse('$baseUrl/open-orders/generate-token/$typeCode'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['token'] ?? 'UNKNOWN';
    } else {
      throw Exception('Failed to generate token');
    }
  }


}
