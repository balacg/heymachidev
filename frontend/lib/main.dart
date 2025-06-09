// lib/main.dart

import 'package:flutter/material.dart';
import 'screens/login/login_screen.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/profile/user_profile_screen.dart';
import 'screens/settings/settings_screen.dart';
import 'screens/master/master_dashboard_screen.dart';
import 'screens/transactions/transaction_history_screen.dart';
import 'screens/admin/admin_center_screen.dart';
import 'screens/billing/item_catalog_page.dart';
import 'screens/billing/final_billing_page.dart';

/// Global notifier for theme mode
ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);

void main() {
  runApp(const HeyMachiApp());
}

class HeyMachiApp extends StatelessWidget {
  const HeyMachiApp({Key? key}) : super(key: key);

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
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case '/':
                return MaterialPageRoute(builder: (_) => LoginScreen());
              case '/dashboard':
                return MaterialPageRoute(builder: (_) => const DashboardScreen());
              case '/profile':
                return MaterialPageRoute(
                  builder: (_) => UserProfileScreen(
                    userName: 'Bala G',
                    userEmail: 'bala@example.com',
                    userRole: 'Admin',
                    showAdminSettings: true,
                  ),
                );
              case '/settings':
                return MaterialPageRoute(builder: (_) => const SettingsScreen());
              case '/masters':
                return MaterialPageRoute(builder: (_) => const MasterDashboardScreen());
              case '/transactions':
                return MaterialPageRoute(builder: (_) => const TransactionHistoryScreen());
              case '/admin_center':
                return MaterialPageRoute(builder: (_) => const AdminCenterScreen());
              case '/catalog':
                return MaterialPageRoute(builder: (_) => const ItemCatalogPage());
              case '/finalBilling':
                final cartItems = settings.arguments as Map<String, dynamic>;
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
