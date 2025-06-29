// restaurant/frontend/lib/utils/restaurant_order_utils.dart

import 'package:flutter/material.dart';
import 'package:restaurant_addon/constants/dining_types.dart';
import 'package:restaurant_addon/services/restaurant_api.dart';
import 'package:heymachi_dev/utils/app_session.dart';

Future<String?> saveRestaurantOrderHandler(Map<String, dynamic> payload) async {

  final cartItemsMap = payload['cartItems'] as Map<String, dynamic>;
  final orderId = payload['id'];

  final List<Map<String, dynamic>> itemList = cartItemsMap.entries.map((entry) {
    final item = entry.value as Map<String, dynamic>;
    return {
      'product_id': entry.key,
      'quantity': item['qty'],
      'price': item['price'],
    };
  }).toList();
  print("💾 saveRestaurantOrderHandler CALLED with ${itemList.length} items");

  final orderPayload = {
    "id": orderId,
    "items": itemList,
    "dining_mode": AppSession.instance.sessionData['dining_mode'] ?? DiningTypes.dineIn,
    "table_no": AppSession.instance.sessionData['table_no'],
    "pax": AppSession.instance.sessionData['pax'],
    "token_no": AppSession.instance.sessionData['token_no'],
    "customer_name": AppSession.instance.sessionData['customer_name'],
    "total_amount": itemList.fold<double>(0, (sum, item) => sum + (item['price'] as double) * (item['quantity'] as int)),
  };

  debugPrint("📤 Final transformed payload: $orderPayload");

  final orderPayloadId = await RestaurantApi.saveOpenOrder(orderPayload);
  return orderPayloadId;

}
