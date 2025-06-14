// lib/screens/billing/final_billing_page.dart

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import '../../services/api.dart';
import '../../models/customer.dart';
import '../../models/transaction_record.dart';
import '../../services/payment_type_service.dart';
import '../../widgets/customer_search_dropdown.dart';
import '../master/customer_add_screen.dart';
import 'order_confirmation_screen.dart';
import '../../models/promotion.dart';
import '../../services/promotion_service.dart';

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
  String businessState = 'Tamil Nadu';
  final formatter = NumberFormat('#,##0.00', 'en_IN');

  Promotion? _selectedPromo;

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

  double get _discount {
    if (_selectedPromo != null) {
      return _subtotal * (_selectedPromo!.discountPercentage / 100);
    }
    return 0;
  }

  bool get isInterstate {
    if (_selectedCustomer?.state == null) return false;
    return _selectedCustomer!.state!.toLowerCase().trim() != businessState.toLowerCase().trim();
  }

  double get _igst => isInterstate ? (_subtotal - _discount) * 0.18 : 0;
  double get _cgst => isInterstate ? 0 : (_subtotal - _discount) * 0.09;
  double get _sgst => isInterstate ? 0 : (_subtotal - _discount) * 0.09;
  double get _totalGst => _cgst + _sgst + _igst;
  double get _total => _subtotal + _totalGst - _discount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Billing Summary'),
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.iconTheme.color,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => false);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomerSearchDropdown(
                          onCustomerSelected: (c) => setState(() => _selectedCustomer = c),
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
                if (_selectedCustomer != null) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_selectedCustomer!.name, style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)),
                            Text('${_selectedCustomer!.phone} | ${_selectedCustomer!.email ?? ''}', style: theme.textTheme.bodyMedium),
                            Text(_selectedCustomer!.address ?? '', style: theme.textTheme.bodyMedium),
                            Text('${_selectedCustomer!.state ?? 'N/A'} | GST: ${_selectedCustomer!.gst ?? ''}', style: theme.textTheme.bodyMedium),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
                    Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_selectedPromo != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        const Icon(Icons.verified, size: 20, color: Colors.green),
                        const SizedBox(width: 8),
                        Text(
                          'Promo: ${_selectedPromo!.title} (${_selectedPromo!.discountPercentage}%)',
                          style: TextStyle(color: Colors.green.shade700, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: _applyPromotion,
                      child: Row(
                        children: const [
                          Text("View All Promotions", style: TextStyle(fontSize: 16)),
                          SizedBox(width: 4),
                          Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                    if (_selectedPromo != null)
                      TextButton.icon(
                        onPressed: () {
                          setState(() => _selectedPromo = null);
                        },
                        icon: const Icon(Icons.cancel, size: 18, color: Colors.red),
                        label: const Text("Remove", style: TextStyle(color: Colors.red)),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: widget.cartItems.entries.map((e) {
                final price = e.value['price'] as double;
                final qty = e.value['qty'] as int;
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  dense: true,
                  visualDensity: const VisualDensity(vertical: -2),
                  title: Text(e.key, style: theme.textTheme.bodyLarge),
                  subtitle: Text('₹${formatter.format(price)} x $qty', style: theme.textTheme.bodyMedium),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                _buildRow(theme, 'Subtotal', _subtotal),
                if (_cgst > 0) _buildRow(theme, 'CGST (9%)', _cgst),
                if (_sgst > 0) _buildRow(theme, 'SGST (9%)', _sgst),
                if (_igst > 0) _buildRow(theme, 'IGST (18%)', _igst),
                _buildRow(theme, 'Total GST', _totalGst),
                if (_discount > 0)
                  _buildRow(
                    theme,
                    'Promo: ${_selectedPromo!.title} (${_selectedPromo!.discountPercentage}%)',
                    -_discount,
                  ),
                const Divider(),
                _buildRow(theme, 'Total', _total, isTotal: true),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: Container(
                color: theme.cardColor,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: PopupMenuButton<String>(
                  initialValue: _selectedPayment,
                  onSelected: (v) => setState(() => _selectedPayment = v),
                  itemBuilder: (_) => _paymentTypes.map((p) => PopupMenuItem(value: p, child: Text(p))).toList(),
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
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: (_selectedCustomer != null && _selectedPayment != null)
                    ? () async {
                        final cust = _selectedCustomer!;
                        final billId = const Uuid().v4();
                        final now = DateTime.now();

                        final lines = widget.cartItems.entries.map((e) {
                          final price = e.value['price'] as double;
                          final qty = e.value['qty'] as int;
                          final taxAmt = isInterstate ? (price * qty - (price * qty * (_selectedPromo?.discountPercentage ?? 0) / 100)) * 0.18 : (price * qty - (price * qty * (_selectedPromo?.discountPercentage ?? 0) / 100)) * 0.18;
                          final cgst = isInterstate ? 0 : taxAmt / 2;
                          final sgst = isInterstate ? 0 : taxAmt / 2;
                          final igst = isInterstate ? taxAmt : 0;
                          final lineTotal = price * qty + taxAmt;
                          return TransactionRecord(
                            billId: billId,
                            lineId: const Uuid().v4(),
                            date: now,
                            customerName: cust.name,
                            customerPhone: cust.phone,
                            customerGst: cust.gst ?? '',
                            address: cust.address ?? '',
                            productName: e.key,
                            category: '',
                            quantity: qty,
                            unitPrice: price,
                            gstSlab: isInterstate ? 'IGST 18%' : 'GST 18%',
                            gstRate: 18.0,
                            taxAmount: taxAmt,
                            cgst: cgst.toDouble(),
                            sgst: sgst.toDouble(),
                            igst: igst.toDouble(),
                            totalAmount: lineTotal,
                            paymentMode: _selectedPayment!,
                            branch: 'Main Branch',
                          );
                        }).toList();

                        final displayItems = widget.cartItems.entries.map((e) {
                          final price = e.value['price'] as double;
                          final qty = e.value['qty'] as int;
                          final tax = isInterstate ? price * qty * 0.18 : price * qty * 0.18;
                          final total = price * qty + tax;
                          return {
                            'productName': e.key,
                            'unitPrice': price,
                            'quantity': qty,
                            'totalAmount': total,
                          };
                        }).toList();

                        final bill = {
                          "id": billId,
                          "date": now.toIso8601String(),
                          "customer_name": cust.name,
                          "customer_phone": cust.phone,
                          "customer_gst": cust.gst ?? '',
                          "address": cust.address ?? '',
                          "total_amount": _total,
                          "payment_mode": _selectedPayment!,
                          "branch": "Main Branch",
                          "promo_title": _selectedPromo?.title,
                          "promo_discount_percentage": _selectedPromo?.discountPercentage,
                          "promo_discount_value": _discount,
                        };

                        await ApiService.postTransaction({
                          "bill": bill,
                          "bill_items": lines.map((e) => e.toJson()).toList(),
                        });

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OrderConfirmationScreen(
                              customer: cust,
                              paymentMode: _selectedPayment!,
                              totalAmount: _total,
                              orderId: billId,
                              cgst: _cgst,
                              sgst: _sgst,
                              igst: _igst,
                              items: displayItems,
                              promoTitle: _selectedPromo?.title,
                              promoPercentage: _selectedPromo?.discountPercentage,
                              promoDiscount: _discount,
                            ),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
    final style = isTotal ? theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold) : theme.textTheme.bodyMedium;
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

  Future<void> _applyPromotion() async {
    final promos = await PromotionService.fetchPromotions();
    final now = DateTime.now();
    final activePromos = promos.where((p) {
      final from = DateTime.parse(p.startDate.toString());
      final to = DateTime.parse(p.endDate.toString());
      return now.isAfter(from) && now.isBefore(to);
    }).toList();

    if (activePromos.isEmpty) return;

    final selected = await showDialog<Promotion>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Select Promotion"),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: activePromos.length,
            itemBuilder: (_, i) {
              final promo = activePromos[i];
              return ListTile(
                title: Text(promo.title),
                subtitle: Text(promo.description),
                trailing: Text('${promo.discountPercentage}%'),
                onTap: () => Navigator.pop(ctx, promo),
              );
            },
          ),
        ),
      ),
    );

    if (selected != null) {
      setState(() => _selectedPromo = selected);
    }
  }
}
