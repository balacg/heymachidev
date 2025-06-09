// lib/screens/dashboard/dashboard_screen.dart

import 'package:flutter/material.dart';
import '../billing/item_catalog_page.dart';
import '../dashboard/dashboard_home.dart';
import '../ledger/ledger_screen.dart';
import '../profile/user_profile_screen.dart';
import '../master/master_dashboard_screen.dart';
import '../transactions/transaction_history_screen.dart';
import '../admin/admin_center_screen.dart';

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
    _pages = [
      const DashboardHome(userName: 'Bala G'),
      const ItemCatalogPage(),
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
    // ────────────────────────────────────────────────
    // If Billing (index == 1) is selected, show that
    // page full-screen (hides the outer AppBar + nav bar)
    if (_selectedIndex == 1) {
      return _pages[1];
    }
    // ────────────────────────────────────────────────

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
          BottomNavigationBarItem(icon: Icon(Icons.point_of_sale), label: 'Billing'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Ledger'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
      ),
    );
  }
}
