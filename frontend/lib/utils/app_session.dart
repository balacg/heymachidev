import 'package:flutter/material.dart';

class AppSession {
  static final AppSession instance = AppSession._internal();
  AppSession._internal();

  String? industryId;
  String? businessId;
  Map<String, dynamic> sessionData = {};

  /// A builder for the billing header in ItemCatalogPage.
  Widget Function()? billingHeaderBuilder;

  void clear() {
    sessionData = {};
    billingHeaderBuilder = null;
  }
}
