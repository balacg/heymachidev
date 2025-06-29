// restaurant/frontend/lib/utils/bootstrap.dart

import 'package:heymachi_dev/utils/app_session.dart';
import 'package:restaurant_addon/constants/dining_types.dart';
import 'package:restaurant_addon/services/restaurant_api.dart';
import 'package:restaurant_addon/screens/billing/restaurant_final_billing_page.dart';

void patchRestaurantTokenLogic() {
  // 🪪 Token logic
  AppSession.instance.ensureRestaurantTokenIfNeeded = () async {
    final data = AppSession.instance.sessionData;
    if (!data.containsKey('token_no') && data['dining_mode'] != DiningTypes.dineIn) {
      final prefix = data['dining_mode'] == DiningTypes.delivery ? 'DL' : 'TK';
      final token = await RestaurantApi.getTokenForType(prefix);
      AppSession.instance.sessionData['token_no'] = token;
    }
  };

  // 🧾 Final billing override
  AppSession.instance.finalBillingPageBuilder = (cartItems) =>
      RestaurantFinalBillingPage(cartItems: cartItems);
}

