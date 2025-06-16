import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api.dart';

class BranchService {
  static Future<List<Map<String, dynamic>>> fetchAllBranches() async {
    final uri = Uri.parse('${ApiService.baseUrl}/branches/');
    final headers = ApiService.headers; // ✅ still sync
    final resp = await http.get(uri, headers: headers);
    if (resp.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(resp.body));
    } else {
      throw Exception('Failed to fetch branches');
    }
  }

  static Future<Map<String, dynamic>> createBranch(Map<String, dynamic> data) async {
    final uri = Uri.parse('${ApiService.baseUrl}/branches/');
    final headers = ApiService.headers;
    final resp = await http.post(uri, headers: headers, body: jsonEncode(data));
    if (resp.statusCode == 200 || resp.statusCode == 201) {
      return jsonDecode(resp.body);
    } else {
      throw Exception('Failed to create branch');
    }
  }

  static Future<Map<String, dynamic>> updateBranch(String id, Map<String, dynamic> data) async {
    final uri = Uri.parse('${ApiService.baseUrl}/branches/$id');

    // ✅ extra null/empty token check BEFORE sending request
    final headers = ApiService.headers;
    print('Sending headers: ${ApiService.headers}');
    print('Sending body: ${jsonEncode(data)}');
    
    if (!headers.containsKey('Authorization') || headers['Authorization']!.trim().isEmpty) {
      throw Exception("Auth token is missing while updating branch");
    }

    final resp = await http.put(uri, headers: headers, body: jsonEncode(data));
    if (resp.statusCode == 200) {
      return jsonDecode(resp.body);
    } else if (resp.statusCode == 401) {
      throw Exception('Unauthorized: Please login again');
    } else if (resp.statusCode == 404) {
      throw Exception('Branch not found');
    } else {
      throw Exception('Failed to update branch');
    }
  }

  static Future<void> deleteBranch(String id) async {
    final uri = Uri.parse('${ApiService.baseUrl}/branches/$id');
    final headers = ApiService.headers;
    final resp = await http.delete(uri, headers: headers);
    if (resp.statusCode != 200) {
      throw Exception('Failed to delete branch');
    }
  }

  static Future<Map<String, dynamic>> fetchDefaultBranch() async {
    final uri = Uri.parse('${ApiService.baseUrl}/branches/default');
    final headers = ApiService.headers;
    final resp = await http.get(uri, headers: headers);
    if (resp.statusCode == 200) {
      return jsonDecode(resp.body);
    } else {
      throw Exception("Default branch info not found");
    }
  }
}
