// restaurant/frontend/lib/utils/restaurant_utils.dart

import 'package:heymachi_dev/utils/app_session.dart';

Map<String, String> getRestaurantSessionLabels() {
  final mode = AppSession.instance.sessionData['dining_mode'];
  return {
    'dining_mode': 'Mode',
    if (mode == 'Dine-In') ...{
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
