// lib/screens/dashboard/dashboard_screen.dart
import 'package:flutter/material.dart';
import '../billing/item_catalog_page.dart';
import '../dashboard/dashboard_home.dart';
import '../ledger/ledger_screen.dart';
import '../profile/user_profile_screen.dart';
import '../master/master_dashboard_screen.dart';
import '../transactions/transaction_history_screen.dart';
import '../admin/admin_center_screen.dart';
import '../../utils/app_session.dart';
import '../../utils/industry_config.dart';
import '../../utils/industry_registry.dart';
import 'package:restaurant_addon/screens/billing/orders_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;
  final List<String> _titles = [
    'HeyMachi',
    'Billing',
    'Ledger',
    'Profile',
  ];

  @override
  void initState() {
    super.initState();
    AppSession.instance.industryId = 'restaurant';
    _pages = [
      const DashboardHome(userName: 'Bala G'),
      const OrdersScreen(),
      const LedgerScreen(),
      const UserProfileScreen(
        userName: 'Bala G',
        userEmail: 'bala@example.com',
        userRole: 'Admin',
      ),
    ];
  }

  void _openMoreMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Masters'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MasterDashboardScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Transactions'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TransactionHistoryScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.admin_panel_settings),
              title: const Text('Admin Center'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AdminCenterScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _handleBillingTap() async {
    print('🧭 Billing tapped');

    final industryId = AppSession.instance.industryId;
    print('🏷️ Industry ID: $industryId');

    final config = IndustryRegistry.getConfig(industryId ?? '');
    print('🛠️ Config: $config');

    if (config != null && config.containsKey("preBillingScreen")) {
      final screenId = config["preBillingScreen"];
      print('🎯 PreBilling screen ID: $screenId');

      final screen = IndustryRegistry.resolvePreBillingScreen(screenId);
      print('🧩 Resolved screen: $screen');

      if (screen != null) {
        final result = await Navigator.push<Map<String, dynamic>>(
          context,
          MaterialPageRoute(builder: (_) => screen),
        );

        print('📦 Result from preBilling screen: $result');

        if (result != null) {
          AppSession.instance.sessionData = result;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ItemCatalogPage(),
            ),
          );
        }
      } else {
        print('❌ Screen not resolved!');
      }
    } else {
      print('❌ No config or preBillingScreen found!');
    }
  }



  void _onItemTapped(int index) {
    if (index == 5) {
      _openMoreMenu();
    } else if (index == 2) {
      _handleBillingTap(); 
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    if (_selectedIndex == 1) {
      return _pages[1]; // This is a placeholder only. Billing screen is external.
    }

    return Scaffold(
      appBar: AppBar(title: Text(_titles[_selectedIndex])),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex < 4 ? _selectedIndex : 0,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.point_of_sale), label: 'Billing'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Ledger'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
      ),
    );
  }
}
