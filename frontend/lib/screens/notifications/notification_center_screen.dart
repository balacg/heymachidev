// lib/screens/notifications/notification_center_screen.dart

import 'package:flutter/material.dart';

class NotificationItem {
  final String id;
  final String title;
  final String message;
  bool isRead;
  final DateTime timestamp;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    this.isRead = false,
    required this.timestamp,
  });
}

class NotificationCenterScreen extends StatefulWidget {
  const NotificationCenterScreen({super.key});

  @override
  State<NotificationCenterScreen> createState() => _NotificationCenterScreenState();
}

class _NotificationCenterScreenState extends State<NotificationCenterScreen> {
  List<NotificationItem> notifications = [
    NotificationItem(
      id: '1',
      title: 'Vendor Payment Reminder',
      message: 'Payment of ₹50,000 is due to vendor XYZ by 10th June.',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    NotificationItem(
      id: '2',
      title: 'Salary Disbursed',
      message: 'Salary for May 2025 has been credited to all employees.',
      timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
      isRead: true,
    ),
    NotificationItem(
      id: '3',
      title: 'Purchase Order Alert',
      message: 'New purchase order #PO12345 has been placed.',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

  void markAllRead() {
    setState(() {
      for (var n in notifications) {
        n.isRead = true;
      }
    });
  }

  void toggleRead(String id) {
    setState(() {
      final index = notifications.indexWhere((n) => n.id == id);
      if (index != -1) {
        notifications[index].isRead = !notifications[index].isRead;
      }
    });
  }

  void deleteNotification(String id) {
    setState(() {
      notifications.removeWhere((n) => n.id == id);
    });
  }

  String formattedTime(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);

    if (diff.inMinutes < 60) {
      return '${diff.inMinutes} min ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} hr ago';
    } else {
      return '${diff.inDays} day${diff.inDays > 1 ? 's' : ''} ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Center'),
        actions: [
          TextButton(
            onPressed: markAllRead,
            child: const Text('Mark All Read', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
      body: notifications.isEmpty
          ? const Center(child: Text('No notifications'))
          : ListView.separated(
              itemCount: notifications.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final n = notifications[index];
                return ListTile(
                  tileColor: n.isRead ? Colors.grey[200] : Colors.white,
                  title: Text(n.title, style: TextStyle(fontWeight: n.isRead ? FontWeight.normal : FontWeight.bold)),
                  subtitle: Text(n.message),
                  leading: Icon(n.isRead ? Icons.mark_email_read : Icons.mark_email_unread, color: n.isRead ? Colors.grey : Colors.indigo),
                  trailing: SizedBox(
                    width: 110,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(formattedTime(n.timestamp), style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'toggle_read') {
                              toggleRead(n.id);
                            } else if (value == 'delete') {
                              deleteNotification(n.id);
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 'toggle_read',
                              child: Text(n.isRead ? 'Mark as Unread' : 'Mark as Read'),
                            ),
                            const PopupMenuItem(value: 'delete', child: Text('Delete')),
                          ],
                          icon: const Icon(Icons.more_vert),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    if (!n.isRead) {
                      toggleRead(n.id);
                    }
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text(n.title),
                        content: Text(n.message),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
                        ],
                      ),
                    );
                  },
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                );
              },
            ),
    );
  }
}
