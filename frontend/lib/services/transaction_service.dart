// lib/services/transaction_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/transaction_record.dart';

class TransactionService {
  static const _baseUrl = 'http://localhost:8000';  // or use ApiService.baseUrl if centralized

  static Future<List<TransactionRecord>> getAll() async {
    final uri = Uri.parse('$_baseUrl/transactions/');
    final resp = await http.get(uri);

    if (resp.statusCode == 200) {
      final List data = jsonDecode(resp.body);
      return data.map((e) => TransactionRecord.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load transactions: ${resp.statusCode}');
    }
  }

  static Future<void> saveAll(List<TransactionRecord> lines) async {
    // You already handle posting individually in final_billing_page.dart
    // so nothing is needed here for now
  }
}
