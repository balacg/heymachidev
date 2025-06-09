// lib/models/notification.dart

enum NotificationType {
  vendorPayment,
  salaryReminder,
  purchaseOrder,
  stockAlert,
  systemError,
  other,
}

enum NotificationStatus {
  unread,
  read,
  acknowledged,
}

class NotificationItem {
  final String id;
  final NotificationType type;
  final String message;
  final String? details; // optional extended info
  final String recipientRole; // e.g., 'admin', 'manager'
  NotificationStatus status;
  final DateTime createdAt;
  final bool actionRequired;

  NotificationItem({
    required this.id,
    required this.type,
    required this.message,
    this.details,
    required this.recipientRole,
    this.status = NotificationStatus.unread,
    required this.createdAt,
    this.actionRequired = false,
  });
}
