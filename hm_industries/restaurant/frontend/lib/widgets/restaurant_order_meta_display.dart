// restaurant/frontend/lib/widgets/restaurant_order_meta_display.dart

import 'package:flutter/material.dart';
import 'package:heymachi_dev/widgets/order_meta_display.dart';
import 'package:heymachi_dev/utils/app_session.dart';

class RestaurantOrderMetaDisplay extends StatelessWidget {
  final TextStyle? style;

  const RestaurantOrderMetaDisplay({Key? key, this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sessionData = AppSession.instance.sessionData;
    final industryLabels = AppSession.instance.getSessionLabels();

    if (sessionData.isEmpty || industryLabels.isEmpty) {
      return const SizedBox();
    }

    final diningMode = sessionData['dining_mode'];

    // Filter logic: hide table_no and pax if not Dine-In
    final filteredData = {
      for (final entry in sessionData.entries)
        if (!(diningMode != 'Dine-In' && (entry.key == 'table_no' || entry.key == 'pax')))
          entry.key: entry.value.toString()
    };

    return OrderMetaDisplay(
      sessionData: filteredData.map((k, v) => MapEntry(k, v.toString())),
      sessionLabels: industryLabels,
      style: style,
    );
  }
}
