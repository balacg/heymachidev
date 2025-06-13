// lib/screens/master/customer_add_screen.dart

import 'package:flutter/material.dart';
import '../../models/customer.dart';
import '../../services/api.dart';

class CustomerAddScreen extends StatefulWidget {
  const CustomerAddScreen({Key? key}) : super(key: key);

  @override
  State<CustomerAddScreen> createState() => _CustomerAddScreenState();
}

class _CustomerAddScreenState extends State<CustomerAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController    = TextEditingController();
  final phoneController   = TextEditingController();
  final emailController   = TextEditingController();
  final gstController     = TextEditingController();
  final addressController = TextEditingController();
  String? selectedState;

  bool isSaving = false;

  final List<String> states = [
    "Andhra Pradesh", "Arunachal Pradesh", "Assam", "Bihar", "Chhattisgarh",
    "Goa", "Gujarat", "Haryana", "Himachal Pradesh", "Jharkhand", "Karnataka",
    "Kerala", "Madhya Pradesh", "Maharashtra", "Manipur", "Meghalaya",
    "Mizoram", "Nagaland", "Odisha", "Punjab", "Rajasthan", "Sikkim",
    "Tamil Nadu", "Telangana", "Tripura", "Uttar Pradesh", "Uttarakhand",
    "West Bengal", "Andaman and Nicobar Islands", "Chandigarh", "Dadra and Nagar Haveli",
    "Daman and Diu", "Delhi", "Jammu and Kashmir", "Ladakh", "Lakshadweep", "Puducherry"
  ];

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    gstController.dispose();
    addressController.dispose();
    super.dispose();
  }

  Future<void> saveCustomer() async {
    if (!_formKey.currentState!.validate() || selectedState == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields and select state")),
      );
      return;
    }

    setState(() => isSaving = true);

    final customer = Customer(
      id:      0,
      name:    nameController.text.trim(),
      phone:   phoneController.text.trim(),
      email:   emailController.text.trim(),
      gst:     gstController.text.trim(),
      address: addressController.text.trim(),
      state:   selectedState,
    );

    try {
      await ApiService.addCustomer(customer);
      if (!mounted) return;
      Navigator.pop(context, customer);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save customer')),
      );
    } finally {
      setState(() => isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Customer'),
        backgroundColor: theme.appBarTheme.backgroundColor,
        foregroundColor: theme.appBarTheme.foregroundColor,
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildField(
                controller: nameController,
                label: 'Customer Name',
                validatorMsg: 'Enter name',
              ),
              const SizedBox(height: 16),
              _buildField(
                controller: phoneController,
                label: 'Phone Number',
                keyboardType: TextInputType.phone,
                validatorMsg: 'Enter valid phone',
              ),
              const SizedBox(height: 16),
              _buildField(
                controller: emailController,
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                validatorMsg: 'Enter valid email',
              ),
              const SizedBox(height: 16),
              _buildField(
                controller: gstController,
                label: 'GST Number',
                validatorMsg: 'Enter GST number',
              ),
              const SizedBox(height: 16),
              _buildField(
                controller: addressController,
                label: 'Address',
                validatorMsg: 'Enter address',
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedState,
                decoration: const InputDecoration(
                  labelText: 'State',
                  border: OutlineInputBorder(),
                ),
                items: states.map((s) {
                  return DropdownMenuItem(
                    value: s,
                    child: Text(s),
                  );
                }).toList(),
                onChanged: (val) => setState(() => selectedState = val),
                validator: (val) =>
                    (val == null || val.isEmpty) ? 'Select a state' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: isSaving ? null : saveCustomer,
                icon: const Icon(Icons.save),
                label: Text(isSaving ? 'Saving...' : 'Save Customer'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required String validatorMsg,
    TextInputType keyboardType = TextInputType.text,
  }) {
    final theme = Theme.of(context);
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: theme.textTheme.bodyMedium,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: theme.textTheme.labelMedium,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.dividerColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.colorScheme.primary),
        ),
      ),
      validator: (value) =>
          (value == null || value.trim().isEmpty) ? validatorMsg : null,
    );
  }
}
