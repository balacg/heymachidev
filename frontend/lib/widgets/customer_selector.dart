// lib/widgets/customer_selector.dart

import 'package:flutter/material.dart';
import '../services/api.dart';
import '../models/customer.dart';

class CustomerSelector extends StatefulWidget {
  final Function(Customer) onCustomerSelected;

  const CustomerSelector({Key? key, required this.onCustomerSelected}) : super(key: key);

  @override
  State<CustomerSelector> createState() => _CustomerSelectorState();
}

class _CustomerSelectorState extends State<CustomerSelector> {
  List<Customer> allCustomers = [];
  List<Customer> filtered = [];
  bool isLoading = true;
  bool expanded = false;

  @override
  void initState() {
    super.initState();
    fetchCustomers();
  }

  Future<void> fetchCustomers() async {
    try {
      final data = await ApiService.fetchCustomers();
      setState(() {
        allCustomers = data;
        filtered = data;
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Error loading customers: $e");
      setState(() => isLoading = false);
    }
  }

  void search(String value) {
    final lower = value.toLowerCase();
    setState(() {
      filtered = allCustomers.where((c) => c.phone.contains(lower)).toList();
    });
  }

  void showAddCustomerDialog() {
    String name = '';
    String phone = '';
    String email = '';
    String gst = '';
    String address = '';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add New Customer"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "Name"),
                onChanged: (val) => name = val,
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Phone"),
                keyboardType: TextInputType.phone,
                onChanged: (val) => phone = val,
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
                onChanged: (val) => email = val,
              ),
              TextField(
                decoration: const InputDecoration(labelText: "GST Number"),
                onChanged: (val) => gst = val,
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Address"),
                onChanged: (val) => address = val,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (name.isNotEmpty && phone.isNotEmpty) {
                final newCustomer = Customer(
                  id:      0,
                  name:    name,
                  phone:   phone,
                  email:   email,
                  gst:     gst,
                  address: address,
                );
                await ApiService.addCustomer(newCustomer);
                Navigator.of(context).pop();
                widget.onCustomerSelected(newCustomer);
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final listToShow = expanded ? filtered : filtered.take(3).toList();

    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Customer",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Search by Phone Number',
                labelStyle: TextStyle(color: Colors.white70),
                prefixIcon: Icon(Icons.search, color: Colors.white54),
                enabledBorder:
                    OutlineInputBorder(borderSide: BorderSide(color: Colors.white38)),
                focusedBorder:
                    OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
              ),
              onChanged: search,
            ),
            const SizedBox(height: 12),
            if (isLoading)
              const CircularProgressIndicator()
            else
              Column(
                children: listToShow.map((customer) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(customer.name,
                        style: const TextStyle(color: Colors.white)),
                    subtitle: Text(
                        '${customer.phone}\n${customer.address}',
                        style: const TextStyle(color: Colors.white54)),
                    trailing: const Icon(Icons.check_circle_outline, color: Colors.white),
                    onTap: () => widget.onCustomerSelected(customer),
                  );
                }).toList(),
              ),
            const SizedBox(height: 8),
            if (!expanded && filtered.length > 3)
              TextButton(
                onPressed: () => setState(() => expanded = true),
                child: const Text("View More"),
              ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: showAddCustomerDialog,
              icon: const Icon(Icons.person_add),
              label: const Text("Add New Customer"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple, foregroundColor: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
