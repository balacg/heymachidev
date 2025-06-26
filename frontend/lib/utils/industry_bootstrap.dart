// lib/utils/industry_bootstrap.dart

import 'package:heymachi_dev/utils/app_session.dart';
import 'package:restaurant_addon/screens/billing/restaurant_order_confirmation_screen.dart';

void setupIndustryOverrides(String industryId) {
  if (industryId == 'restaurant') {
    AppSession.instance.orderConfirmationBuilder = ({
      required customer,
      required paymentMode,
      required totalAmount,
      required orderId,
      required cgst,
      required sgst,
      required igst,
      required items,
      required Map<String, dynamic> sessionData,
      required Map<String, String> sessionLabels,
      String? promoTitle,
      double? promoPercentage,
      double? promoDiscount,
    }) {
      return RestaurantOrderConfirmationScreen(
        customer: customer,
        paymentMode: paymentMode,
        totalAmount: totalAmount,
        orderId: orderId,
        cgst: cgst,
        sgst: sgst,
        igst: igst,
        items: items,
        sessionData: sessionData,
        sessionLabels: sessionLabels,
        promoTitle: promoTitle,
        promoPercentage: promoPercentage,
        promoDiscount: promoDiscount,
      );
    };

  }

  // Future: add other industry overrides here
}
