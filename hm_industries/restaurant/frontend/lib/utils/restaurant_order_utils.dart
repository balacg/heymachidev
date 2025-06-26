// restaurant/frontend/lib/utils/restaurant_order_utils.dart

import 'package:restaurant_addon/services/restaurant_api.dart';

Future<void> saveRestaurantOrderHandler(Map<String, dynamic> payload) async {
  print('🍽 Saving restaurant order via saveOpenOrder...');
  await RestaurantApi.saveOpenOrder(payload);
}
