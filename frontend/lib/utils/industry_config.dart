// lib/utils/industry_config.dart

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class IndustryConfig {
  static late final Map<String, dynamic> _cfg;
  static const String defaultIndustryId = 'restaurant';

  /// Call this once at app startup to load the JSON.
  static Future<void> load() async {
    final raw = await rootBundle.loadString('assets/industry_config.json');
    _cfg = jsonDecode(raw) as Map<String, dynamic>;
  }

  /// Returns the config map for a given industry ID, or null if not found.
  static Map<String, dynamic>? forIndustry(String id) {
    return _cfg[id] as Map<String, dynamic>?;
  }
}
