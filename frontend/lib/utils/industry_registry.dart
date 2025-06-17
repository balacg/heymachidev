import 'package:flutter/material.dart';
import 'package:restaurant_addon/screens/dining_selector_page.dart';

class IndustryRegistry {
  static final Map<String, Map<String, dynamic>> _config = {
    "restaurant": {
      "preBillingScreen": "DiningSelectorPage",
      "sessionFields": {
      "diningType": "Dining Mode",
      "tableNo": "Table",
      "pax": "Pax"}
    },
    // stub for other industries
    "clinic": {
      "preBillingScreen": "PatientInfoForm",
      "sessionFields": {"patientName": "Patient Name", "appointmentSlot":"Appointment Slot"}
    },
  };

  static Map<String, dynamic>? getConfig(String industryId) {
    return _config[industryId];
  }

  /// Only returns widgets that return a Map<String,dynamic> on Navigator.pop.
  static Widget? resolvePreBillingScreen(String screenId) {
    switch (screenId) {
      case "DiningSelectorPage":
        return const DiningSelectorPage();
      // case "PatientInfoForm": return const PatientInfoForm();
      default:
        return null;
    }
  }
}
