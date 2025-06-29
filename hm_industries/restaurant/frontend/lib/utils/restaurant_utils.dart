// restaurant/frontend/lib/utils/restaurant_utils.dart

import 'package:heymachi_dev/utils/app_session.dart';
import 'package:restaurant_addon/constants/dining_types.dart';

Map<String, String> getRestaurantSessionLabels() {
  final mode = AppSession.instance.sessionData['dining_mode'];
  return {
    'dining_mode': 'Mode',
    if (mode == DiningTypes.dineIn) ...{
      'table_no': 'Table No',
      'pax': 'Guests',
    } else ...{
      'token_no': 'Token',
    }
  };
}

Map<String, String> getRestaurantSessionData(Map<String, String> labels) {
  return {
    for (final entry in AppSession.instance.sessionData.entries)
      if (labels.containsKey(entry.key) && entry.value.toString().isNotEmpty)
        entry.key: entry.value.toString()
  };
}
