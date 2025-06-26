import 'package:flutter/material.dart';
import 'package:heymachi_dev/screens/billing/final_billing_page.dart';
import 'package:heymachi_dev/widgets/order_meta_display.dart';
import 'package:heymachi_dev/utils/app_session.dart';
import '../../services/restaurant_api.dart';

class RestaurantFinalBillingPage extends StatefulWidget {
  final Map<String, Map<String, dynamic>> cartItems;

  const RestaurantFinalBillingPage({super.key, required this.cartItems});

  @override
  State<RestaurantFinalBillingPage> createState() => _RestaurantFinalBillingPageState();
}

class _RestaurantFinalBillingPageState extends State<RestaurantFinalBillingPage> {
  Future<void> _ensureTokenIfNeeded() async {
    final data = AppSession.instance.sessionData;
    final mode = data['dining_mode'];

    if ((mode == 'Takeaway' || mode == 'Delivery') && !data.containsKey('token_no')) {
      final prefix = mode == 'Takeaway' ? 'TK' : 'DL';
      final token = await RestaurantApi.getTokenForType(prefix);
      data['token_no'] = token;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _ensureTokenIfNeeded(),
      builder: (_, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }

        final sessionData = AppSession.instance.sessionData.map((k, v) => MapEntry(k, v.toString()));
        final fieldMap = AppSession.instance.getSessionLabels();

        return FinalBillingPage(
          cartItems: widget.cartItems,
          metaDisplayOverride: OrderMetaDisplay(
            sessionData: sessionData,
            sessionLabels: fieldMap,
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
        );
      },
    );
  }
}
