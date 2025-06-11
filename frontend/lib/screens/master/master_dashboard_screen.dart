// lib/screens/master/master_dashboard_screen.dart

import 'package:flutter/material.dart';

import 'product_master_screen.dart';
import 'customer_master_screen.dart';
import 'vendor_master_screen.dart';
import 'category_master_screen.dart';
import 'subcategory_master_screen.dart';
import 'unit_master_screen.dart';
import 'tax_master_screen.dart';
import 'payment_type_master_screen.dart';
import 'product_field_config_screen.dart';

class MasterDashboardScreen extends StatelessWidget {
  const MasterDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Masters')),
      body: ListView(
        children: const [
          _MasterTile('Products', Icons.inventory, ProductMasterScreen()),
          _MasterTile('Customers', Icons.person, CustomerMasterScreen()),
          _MasterTile('Vendors', Icons.store, VendorMasterScreen()),
          _MasterTile('Categories', Icons.category, CategoryMasterScreen()),
          _MasterTile('Subcategories', Icons.subtitles, SubcategoryMasterScreen()),
          _MasterTile('Units', Icons.straighten, UnitMasterScreen()),
          _MasterTile('Taxes', Icons.percent, TaxMasterScreen()),
          _MasterTile('Payment Types', Icons.payment, PaymentTypeMasterScreen()),
          _MasterTile('Product Field Config', Icons.settings, ProductFieldConfigScreen()),
        ],
      ),
    );
  }
}

class _MasterTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget screen;

  const _MasterTile(this.title, this.icon, this.screen);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.indigo),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => screen),
        );
      },
    );
  }
}
