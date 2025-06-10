// lib/services/payment_type_service.dart

import 'api.dart';
import '../models/payment_type.dart';

class PaymentTypeService {
  /// Get the full list of payment types from the backend
  static Future<List<PaymentType>> getAll() {
    return ApiService.fetchPaymentTypes();
  }

  /// Create a new payment type
  static Future<PaymentType> create(PaymentType pt) {
    return ApiService.createPaymentType(pt);
  }

  /// Update an existing payment type
  static Future<PaymentType> update(PaymentType pt) {
    return ApiService.updatePaymentType(pt);
  }

  /// Delete by ID
  static Future<void> delete(int id) {
    return ApiService.deletePaymentType(id);
  }
}
