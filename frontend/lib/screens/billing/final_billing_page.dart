// lib/screens/billing/final_billing_page.dart

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

import '../../models/customer.dart';
import '../../models/transaction_record.dart';
import '../../services/transaction_service.dart';
import '../../services/payment_type_service.dart';
import '../../widgets/customer_search_dropdown.dart';
import '../master/customer_add_screen.dart';
import 'order_confirmation_screen.dart';

class FinalBillingPage extends StatefulWidget {
  final Map<String, dynamic> cartItems;

  const FinalBillingPage({Key? key, required this.cartItems}) : super(key: key);

  @override
  State<FinalBillingPage> createState() => _FinalBillingPageState();
}

class _FinalBillingPageState extends State<FinalBillingPage> {
  Customer? _selectedCustomer;
  String? _selectedPayment;
  List<String> _paymentTypes = [];

  final formatter = NumberFormat('#,##0.00', 'en_IN');

  @override
  void initState() {
    super.initState();
    _loadPaymentTypes();
  }

  Future<void> _loadPaymentTypes() async {
    final types = await PaymentTypeService.getAll();
    _paymentTypes = types.map((t) => t.name).toList();
    if (_paymentTypes.isNotEmpty) _selectedPayment = _paymentTypes.first;
    setState(() {});
  }

  double get _subtotal => widget.cartItems.entries.fold<double>(
        0,
        (sum, e) {
          final price = e.value['price'] as double;
          final qty = e.value['qty'] as int;
          return sum + price * qty;
        },
      );
  double get _tax => _subtotal * 0.18;
  double get _discount => 0;
  double get _total => _subtotal + _tax - _discount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Billing Summary'),
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.iconTheme.color,
        leading: const BackButton(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Customer picker + add
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: CustomerSearchDropdown(
                    onSelected: (c) => setState(() => _selectedCustomer = c),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.person_add),
                  onPressed: () async {
                    final newCustomer = await Navigator.push<Customer>(
                      context,
                      MaterialPageRoute(builder: (_) => const CustomerAddScreen()),
                    );
                    if (newCustomer != null) {
                      setState(() => _selectedCustomer = newCustomer);
                    }
                  },
                ),
              ],
            ),
          ),

          // Compact customer card
          if (_selectedCustomer != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Card(
                color: theme.cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _selectedCustomer!.name,
                        style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(_selectedCustomer!.email ?? '', style: theme.textTheme.bodyMedium),
                      const SizedBox(height: 4),
                      Text('${_selectedCustomer!.phone} · GST: ${_selectedCustomer!.gst ?? ''}',
                          style: theme.textTheme.bodyMedium),
                      const SizedBox(height: 4),
                      Text(_selectedCustomer!.address ?? '', style: theme.textTheme.bodyMedium),
                    ],
                  ),
                ),
              ),
            ),

          // Line items
          Expanded(
            child: ListView(
              children: widget.cartItems.entries.map((e) {
                final price = e.value['price'] as double;
                final qty = e.value['qty'] as int;
                return ListTile(
                  tileColor: theme.cardColor,
                  title: Text(e.key, style: theme.textTheme.bodyLarge),
                  subtitle: Text('₹${formatter.format(price)} x $qty', style: theme.textTheme.bodyMedium),
                );
              }).toList(),
            ),
          ),

          // Summary rows
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                _buildRow(theme, 'Subtotal', _subtotal),
                _buildRow(theme, 'GST (18%)', _tax),
                _buildRow(theme, 'Discount', _discount),
                const Divider(),
                _buildRow(theme, 'Total', _total, isTotal: true),
              ],
            ),
          ),
        ],
      ),

      // Bottom bar
      bottomNavigationBar: SizedBox(
        height: 70,
        child: Row(
          children: [
            // Payment dropdown
            Expanded(
              child: Container(
                color: theme.cardColor,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: PopupMenuButton<String>(
                  initialValue: _selectedPayment,
                  onSelected: (v) => setState(() => _selectedPayment = v),
                  itemBuilder: (_) => _paymentTypes
                      .map((p) => PopupMenuItem(value: p, child: Text(p)))
                      .toList(),
                  child: Row(
                    children: [
                      const Icon(Icons.payment),
                      const SizedBox(width: 8),
                      Text(_selectedPayment ?? 'Payment', style: theme.textTheme.bodyMedium),
                    ],
                  ),
                ),
              ),
            ),

            // Pay button
            Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Colors.deepOrange, Colors.pinkAccent]),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextButton(
                onPressed: _selectedCustomer != null && _selectedPayment != null
                    ? () async {
                        final cust = _selectedCustomer!;
                        final billId = const Uuid().v4();
                        final now = DateTime.now();

                        final lines = widget.cartItems.entries.map((e) {
                          final price = e.value['price'] as double;
                          final qty = e.value['qty'] as int;
                          final taxAmt = price * qty * 0.18;
                          final lineTotal = price * qty + taxAmt;
                          return TransactionRecord(
                            billId: billId,
                            lineId: const Uuid().v4(),
                            date: now,
                            customerName: cust.name,
                            customerPhone: cust.phone,
                            customerGst: cust.gst ?? '',
                            productName: e.key,
                            category: '',
                            quantity: qty,
                            unitPrice: price,
                            gstSlab: 'GST 18%',
                            gstRate: 18.0,
                            taxAmount: taxAmt,
                            totalAmount: lineTotal,
                            paymentMode: _selectedPayment!,
                            branch: 'Main Branch',
                          );
                        }).toList();

                        await TransactionService.saveAll(lines);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OrderConfirmationScreen(
                              customer: cust,
                              paymentMode: _selectedPayment!,
                              totalAmount: _total,
                            ),
                          ),
                        );
                      }
                    : null,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                child: Text('Pay ₹${formatter.format(_total)}'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(ThemeData theme, String label, double amt, {bool isTotal = false}) {
    final style = isTotal
        ? theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)
        : theme.textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text('₹${formatter.format(amt)}', style: style),
        ],
      ),
    );
  }
}
