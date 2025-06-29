// lib/modules/industry_plugin_loader.dart

import 'package:heymachi_dev/utils/app_session.dart';

// Import all known industry handlers here
import 'package:restaurant_addon/utils/restaurant_order_utils.dart' as restaurant;

typedef OrderHandler = Future<String?> Function(Map<String, dynamic>);


// This can be expanded to include other plugin types later (e.g. cartLogic, customerLogic, etc.)
class IndustryPluginLoader {
  static OrderHandler? getOrderHandler(String industry) {
    switch (industry.toLowerCase()) {
      case 'restaurant':
        return restaurant.saveRestaurantOrderHandler;

      // case 'clinic':
      //   return clinic.saveClinicOrderHandler;

      default:
        return null;
    }
  }
}
