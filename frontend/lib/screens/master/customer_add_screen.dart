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

  bool isSaving = false;

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
    if (!_formKey.currentState!.validate()) return;

    setState(() => isSaving = true);

    final customer = Customer(
      id:      0,
      name:    nameController.text.trim(),
      phone:   phoneController.text.trim(),
      email:   emailController.text.trim(),
      gst:     gstController.text.trim(),
      address: addressController.text.trim(),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Customer'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
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
              const Spacer(),
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
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orangeAccent),
        ),
      ),
      validator: (value) =>
          (value == null || value.trim().isEmpty) ? validatorMsg : null,
    );
  }
}
