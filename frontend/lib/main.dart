// lib/main.dart


import 'package:flutter/material.dart';
import 'package:heymachi_dev/utils/app_session.dart';
import 'package:heymachi_dev/utils/industry_plugin_loader.dart';
//import 'package:restaurant_addon/screens/billing/table_selector.dart';
import 'package:restaurant_addon/utils/restaurant_order_utils.dart';

import 'utils/industry_config.dart';
import 'screens/auth/login_screen.dart';
import 'screens/navigation/main_navigation_screen.dart';
import 'screens/profile/user_profile_screen.dart';
import 'screens/settings/business_profile_screen.dart';
import 'screens/master/master_dashboard_screen.dart';
import 'screens/transactions/transaction_history_screen.dart';
import 'screens/admin/admin_center_screen.dart';
import 'screens/billing/item_catalog_page.dart';
import 'screens/billing/final_billing_page.dart';
import 'services/api.dart';


/// Global notifier for theme mode
ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IndustryConfig.load();

  // Fake example — replace this with real config fetch
  final industry = IndustryConfig.defaultIndustryId;
  
  AppSession.instance.orderSaveHandler = IndustryPluginLoader.getOrderHandler(industry);

  debugPrint('🧩 Registered order handler for $industry');
  
  runApp(const HeyMachiApp());
}


class HeyMachiApp extends StatelessWidget {
  const HeyMachiApp({Key? key}) : super(key: key);

  Future<bool> isLoggedIn() async {
  try {
    final token = await ApiService.getToken(); // 👈 your shared prefs or secure store logic
    if (token == null) return false;

    ApiService.setToken(token); // 👈 set the Authorization header before calling fetchUserSession
    await ApiService.fetchUserSession();
    return true;
  } catch (_) {
    return false;
  }
}

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, mode, _) {
        return MaterialApp(
          title: 'HeyMachi',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.indigo,
          ),
          darkTheme: ThemeData(brightness: Brightness.dark),
          themeMode: mode,
          home: FutureBuilder<bool>(
            future: isLoggedIn(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(body: Center(child: CircularProgressIndicator()));
              }
              if (snapshot.data == true) {
                return const MainNavigationScreen();
              } else {
                return const LoginScreen();
              }
            },
          ),
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
            //  case '/table-selector':
              //  return MaterialPageRoute(builder: (_) => const TableSelectorPage());
              case '/dashboard':
                return MaterialPageRoute(builder: (_) => const MainNavigationScreen());
              case '/profile':
                return MaterialPageRoute(
                  builder: (_) => UserProfileScreen(
                    userName: ApiService.currentUser?['username'] ?? '',
                    userEmail: ApiService.currentUser?['email'] ?? '',
                    userRole: ApiService.currentUser?['is_admin'] == true ? 'Admin' : 'User',
                    showAdminSettings: ApiService.currentUser?['is_admin'] == true,
                  ),
                );
              case '/settings':
                return MaterialPageRoute(builder: (_) => const BusinessProfileScreen());
              case '/masters':
                return MaterialPageRoute(builder: (_) => const MasterDashboardScreen());
              case '/transactions':
                return MaterialPageRoute(builder: (_) => const TransactionHistoryScreen());
              case '/admin_center':
                return MaterialPageRoute(builder: (_) => const AdminCenterScreen());
              case '/catalog':
                return MaterialPageRoute(builder: (_) => const ItemCatalogPage());
              case '/finalBilling':
                final cartItems = settings.arguments as Map<String, Map<String, dynamic>>;
                return MaterialPageRoute(
                  builder: (_) => FinalBillingPage(cartItems: cartItems),
                );
              default:
                return MaterialPageRoute(
                  builder: (_) => const Scaffold(
                    body: Center(child: Text('Page not found')),
                  ),
                );
            }
          },
        );
      },
    );
  }
}
