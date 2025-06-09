import 'package:uuid/uuid.dart';
import '../models/payment_type.dart';

class PaymentTypeService {
  static final _uuid = Uuid();
  static final List<PaymentType> _types = [];

  /// Fetch all payment types
  static Future<List<PaymentType>> getAll() async {
    // In real app, replace with DB/API call
    return List.from(_types);
  }

  /// Add or update a payment type
  static Future<void> upsert(PaymentType pt) async {
    final idx = _types.indexWhere((t) => t.id == pt.id);
    if (idx >= 0) {
      _types[idx] = pt;
    } else {
      _types.add(PaymentType(id: _uuid.v4(), name: pt.name));
    }
  }

  /// Delete by id
  static Future<void> delete(String id) async {
    _types.removeWhere((t) => t.id == id);
  }
}
