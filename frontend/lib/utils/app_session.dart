import 'package:flutter/material.dart';
import 'package:heymachi_dev/models/customer.dart';
import 'package:heymachi_dev/utils/industry_config.dart';
typedef OrderHandler = Future<String?> Function(Map<String, dynamic> payload);

class AppSession {
  static final AppSession instance = AppSession._internal();
  AppSession._internal();

  String? industryId;
  String? businessId;
  Map<String, dynamic> sessionData = {};
  Future<void> Function() ensureRestaurantTokenIfNeeded = () async {};
  Widget Function(Map<String, Map<String, dynamic>> cartItems)? finalBillingPageBuilder;
  Future<String?> Function(Map<String, dynamic>)? orderSaveHandler;
  
  void Function(BuildContext context)? orderPostSaveRedirect;
  Future<void> Function(BuildContext)? orderCancelHandler;

  /// A builder for the billing header in ItemCatalogPage.
  Widget Function()? billingHeaderBuilder;

  void clear() {
    sessionData = {};
    billingHeaderBuilder = null;
    orderPostSaveRedirect = null;
    orderCancelHandler = null;
  }

  Map<String, String> getSessionLabels() {
    final id = this.industryId ?? '';
    final config = IndustryConfig.forIndustry(id);
    final sessionFields = config?['sessionFields'];
    return sessionFields is Map<String, String> ? sessionFields : {};
    
  }

  late Widget Function({
    required Customer customer,
    required String paymentMode,
    required double totalAmount,
    required String orderId,
    required double cgst,
    required double sgst,
    required double igst,
    required List<Map<String, dynamic>> items,
    String? promoTitle,
    double? promoPercentage,
    double? promoDiscount,
    required Map<String, String> sessionData,
    required Map<String, String> sessionLabels,
  })? orderConfirmationBuilder;

}
