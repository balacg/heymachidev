// lib/services/transaction_service.dart

import 'package:uuid/uuid.dart';
import '../models/transaction_record.dart';

class TransactionService {
  static final _uuid = Uuid();
  static final List<TransactionRecord> _records = [];

  /// Save one or more line‐level records
  static Future<void> saveAll(List<TransactionRecord> lines) async {
    _records.addAll(lines);
  }

  /// Fetch every transaction line
  static Future<List<TransactionRecord>> getAll() async {
    return List.from(_records);
  }
}
