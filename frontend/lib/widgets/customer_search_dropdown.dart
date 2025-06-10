// lib/widgets/customer_search_dropdown.dart

import 'package:flutter/material.dart';
import '../models/customer.dart';
import '../services/api.dart';

class CustomerSearchDropdown extends StatefulWidget {
  final void Function(Customer) onSelected;
  final Customer? initialCustomer;

  const CustomerSearchDropdown({
    Key? key,
    required this.onSelected,
    this.initialCustomer,
  }) : super(key: key);

  @override
  State<CustomerSearchDropdown> createState() => _CustomerSearchDropdownState();
}

class _CustomerSearchDropdownState extends State<CustomerSearchDropdown> {
  final TextEditingController _controller = TextEditingController();
  List<Customer> _allCustomers = [];
  List<Customer> _filteredCustomers = [];
  bool _hasTyped = false;

  @override
  void initState() {
    super.initState();
    _fetchCustomers();
    if (widget.initialCustomer != null) {
      _controller.text = widget.initialCustomer!.name;
    }
  }

  Future<void> _fetchCustomers() async {
    try {
      final list = await ApiService.fetchCustomers();
      setState(() => _allCustomers = list);
    } catch (e) {
      debugPrint('Error fetching customers: $e');
    }
  }

  void _search(String query) {
    setState(() => _hasTyped = query.trim().isNotEmpty);
    if (!_hasTyped) {
      setState(() => _filteredCustomers = []);
      return;
    }
    final lower = query.toLowerCase();
    setState(() {
      _filteredCustomers = _allCustomers.where((c) {
        return c.name.toLowerCase().contains(lower) ||
            c.phone.toLowerCase().contains(lower);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        TextField(
          controller: _controller,
          onChanged: _search,
          decoration: InputDecoration(
            filled: true,
            fillColor: isDark ? Colors.grey[900] : Colors.white,
            prefixIcon: Icon(Icons.search, color: isDark ? Colors.white : Colors.grey),
            hintText: 'Search by name or mobile',
            hintStyle: TextStyle(color: isDark ? Colors.white54 : Colors.black38),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColorLight),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
        ),

        if (_hasTyped && _filteredCustomers.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[850] : Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _filteredCustomers.length,
              itemBuilder: (ctx, i) {
                final c = _filteredCustomers[i];
                return ListTile(
                  title: Text(c.name, style: TextStyle(color: isDark ? Colors.white : Colors.black)),
                  subtitle: Text(
                    '${c.phone}\n${c.address}',
                    style: TextStyle(color: isDark ? Colors.white54 : Colors.black54),
                  ),
                  isThreeLine: true,
                  onTap: () {
                    widget.onSelected(c);
                    _controller.text = c.name;
                    setState(() {
                      _filteredCustomers = [];
                      _hasTyped = false;
                    });
                    FocusScope.of(context).unfocus();
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
