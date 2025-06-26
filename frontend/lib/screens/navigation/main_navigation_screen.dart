// lib/screens/navigation/main_navigation_screen.dart

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
import 'package:restaurant_addon/screens/billing/restaurant_orders_screen.dart' as restaurant;

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;
  final List<String> _titles = [
    'HeyMachi',
    'Orders',
    'Ledger',
    'Profile',
  ];

  @override
  void initState() {
    super.initState();
    final industryId = AppSession.instance.industryId ?? IndustryConfig.defaultIndustryId;

    _pages = [
      const DashboardHome(userName: 'Bala G'),
      _buildIndustryPage(industryId),
      const LedgerScreen(),
      const UserProfileScreen(
        userName: 'Bala G',
        userEmail: 'bala@example.com',
        userRole: 'Admin',
      ),
    ];
  }

  Widget _buildIndustryPage(String industryId) {
    switch (industryId) {
      case 'restaurant':
        return const restaurant.RestaurantOrdersScreen(); 
      default:
        return const SizedBox.shrink(); // or a default OrdersPage
    }
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

  



  void _onItemTapped(int index) {
    if (index == 4) {
      _openMoreMenu();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final isMore = _selectedIndex == 4;

    return Scaffold(
      appBar: AppBar(
        title: Text(isMore ? 'More' : _titles[_selectedIndex]),
      ),
      body: isMore ? const SizedBox.shrink() : _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex < 5 ? _selectedIndex : 0, // now safe
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Ledger'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
      ),
    );
  }

}
