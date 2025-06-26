// restaurant/frontend/lib/screens/billing/restaurant_order_confirmation_screen.dart

import 'package:flutter/material.dart';
import 'package:heymachi_dev/models/customer.dart';
import 'package:heymachi_dev/screens/billing/order_confirmation_screen.dart';

class RestaurantOrderConfirmationScreen extends StatelessWidget {
  final Customer customer;
  final String paymentMode;
  final double totalAmount;
  final List<Map<String, dynamic>> items;
  final String orderId;
  final double cgst;
  final double sgst;
  final double igst;

  final String? promoTitle;
  final double? promoPercentage;
  final double? promoDiscount;

  final Map<String, dynamic> sessionData;
  final Map<String, String> sessionLabels;

  const RestaurantOrderConfirmationScreen({
    Key? key,
    required this.customer,
    required this.paymentMode,
    required this.totalAmount,
    required this.items,
    required this.orderId,
    required this.cgst,
    required this.sgst,
    required this.igst,
    required this.sessionData,
    required this.sessionLabels,
    this.promoTitle,
    this.promoPercentage,
    this.promoDiscount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrderConfirmationScreen(
      customer: customer,
      paymentMode: paymentMode,
      totalAmount: totalAmount,
      items: items,
      orderId: orderId,
      cgst: cgst,
      sgst: sgst,
      igst: igst,
      promoTitle: promoTitle,
      promoPercentage: promoPercentage,
      promoDiscount: promoDiscount,
      sessionData: sessionData,
      sessionLabels: sessionLabels,      
    );
  }
}
