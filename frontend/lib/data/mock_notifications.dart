import '../models/notification.dart';

final List<NotificationItem> mockNotifications = [
  NotificationItem(
    id: 'n1',
    type: NotificationType.vendorPayment,
    message: 'Vendor payment due: ₹50,000 for XYZ Supplies',
    recipientRole: 'admin',
    createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    actionRequired: true,
  ),
  NotificationItem(
    id: 'n2',
    type: NotificationType.salaryReminder,
    message: 'Salary disbursal pending for 5 employees',
    recipientRole: 'manager',
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
    actionRequired: true,
  ),
  NotificationItem(
    id: 'n3',
    type: NotificationType.purchaseOrder,
    message: 'New purchase order #1234 needs approval',
    recipientRole: 'admin',
    createdAt: DateTime.now().subtract(const Duration(hours: 5)),
    actionRequired: true,
  ),
];
