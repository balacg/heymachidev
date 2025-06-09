// lib/screens/dashboard/dashboard_home.dart

import 'package:flutter/material.dart';

// Dummy data for now
final todaySalesAmount = 25400;
final todayBillsCount = 23;
final pendingVendorPayments = 78000;
final pendingCustomerDues = 15000;

final recentNotifications = [
  'Vendor payment due for ABC Traders',
  'New purchase order #1234 needs approval',
  'Employee salary disbursal pending',
];

class DashboardHome extends StatelessWidget {
  final String userName;

  const DashboardHome({super.key, this.userName = "Bala G"});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final formattedDate = "${today.day}/${today.month}/${today.year}";

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello, $userName',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            'Today: $formattedDate',
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 24),

          // Summary cards row
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _InfoCard(title: "Today's Sales", value: "₹$todaySalesAmount"),
              _InfoCard(title: "Bills Created", value: "$todayBillsCount"),
              _InfoCard(title: "Vendor Payments Due", value: "₹$pendingVendorPayments"),
              _InfoCard(title: "Customer Dues", value: "₹$pendingCustomerDues"),
            ],
          ),

          const SizedBox(height: 32),

          // Recent notifications preview
          Text(
            'Recent Notifications',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...recentNotifications.take(3).map((note) => Card(
                color: Colors.yellow[100],
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  title: Text(note),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // TODO: Navigate to Notification Center screen
                  },
                ),
              )),

          const SizedBox(height: 32),

          // Quick Actions
          Text(
            'Quick Actions',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 16,
            children: [
              _ActionButton(
                icon: Icons.point_of_sale,
                label: 'Create Bill',
                onPressed: () {
                  // TODO: Navigate to Billing Screen
                },
              ),
              _ActionButton(
                icon: Icons.receipt_long,
                label: 'View Ledger',
                onPressed: () {
                  // TODO: Navigate to Ledger Screen
                },
              ),
              _ActionButton(
                icon: Icons.notifications,
                label: 'Notifications',
                onPressed: () {
                  // TODO: Navigate to Notification Center
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String value;
  const _InfoCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width / 2) - 24,
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          child: Column(
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(value, style: const TextStyle(fontSize: 20, color: Colors.indigo)),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      icon: Icon(icon),
      label: Text(label),
      onPressed: onPressed,
    );
  }
}
