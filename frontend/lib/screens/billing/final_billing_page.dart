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
import '../../utils/app_session.dart';
import '../../utils/industry_config.dart';
import '../../widgets/order_meta_display.dart';

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
    _loadBranchState();
  }

  Future<void> _loadPaymentTypes() async {
    final types = await PaymentTypeService.getAll();
    _paymentTypes = types.map((t) => t.name).toList();
    if (_paymentTypes.isNotEmpty) _selectedPayment = _paymentTypes.first;
    setState(() {});
  }

  Future<void> _loadBranchState() async {
    try {
      final state = await ApiService.fetchBranchState();
      setState(() => businessState = state);
    } catch (_) {}
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
    final custState = _selectedCustomer?.state;
    if (custState == null) return false;
    return custState.toLowerCase().trim() != businessState.toLowerCase().trim();
  }

  double get _igst => isInterstate ? (_subtotal - _discount) * 0.18 : 0;
  double get _cgst => isInterstate ? 0 : (_subtotal - _discount) * 0.09;
  double get _sgst => isInterstate ? 0 : (_subtotal - _discount) * 0.09;
  double get _total => _subtotal + _cgst + _sgst + _igst - _discount;

  void _confirmAndSave() async {
    final cust = _selectedCustomer!;
    final billId = const Uuid().v4();
    final now = DateTime.now();

    final session = AppSession.instance.sessionData;
    final industryId = AppSession.instance.industryId ?? '';
    final raw = IndustryConfig.forIndustry(industryId)?['sessionFields'];
    final fieldMap = (raw is Map)
        ? raw.map((k, v) => MapEntry(k.toString(), v.toString()))
        : <String, String>{};

    final lines = widget.cartItems.entries.map((e) {
      final price = e.value['price'] as double;
      final qty = e.value['qty'] as int;
      final discounted = price * qty * (_selectedPromo?.discountPercentage ?? 0) / 100;
      final taxable = price * qty - discounted;
      final taxAmt = taxable * 0.18;
      final cgst = isInterstate ? 0 : taxAmt / 2;
      final sgst = isInterstate ? 0 : taxAmt / 2;
      final igst = isInterstate ? taxAmt : 0;
      final lineTotal = taxable + taxAmt;

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
        gstSlab: isInterstate ? 'IGST' : 'GST',
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

    await ApiService.postTransaction({
      'bill': {
        'id': billId,
        'date': now.toIso8601String(),
        'customer_name': cust.name,
        'customer_phone': cust.phone,
        'customer_gst': cust.gst ?? '',
        'address': cust.address ?? '',
        'total_amount': _total,
        'payment_mode': _selectedPayment!,
        'branch': 'Main Branch',
        'promo_title': _selectedPromo?.title,
        'promo_discount_percentage': _selectedPromo?.discountPercentage,
        'promo_discount_value': _discount,
      },
      'bill_items': lines.map((l) => l.toJson()).toList(),
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
          items: lines.map((l) => {
            'productName': l.productName,
            'unitPrice': l.unitPrice,
            'quantity': l.quantity,
            'totalAmount': l.totalAmount,
          }).toList(),
          promoTitle: _selectedPromo?.title,
          promoPercentage: _selectedPromo?.discountPercentage,
          promoDiscount: _discount,
          sessionData: session,
          sessionLabels: fieldMap,
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, String label, double value, {bool isTotal = false}) {
    final style = isTotal
        ? Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)
        : Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text('₹${formatter.format(value)}', style: style),
        ],
      ),
    );
  }

  Future<void> _applyPromotion() async {
    final promos = await PromotionService.fetchPromotions();
    final now = DateTime.now();
    final active = promos.where((p) {
      final from = DateTime.parse(p.startDate.toString());
      final to = DateTime.parse(p.endDate.toString());
      return now.isAfter(from) && now.isBefore(to);
    }).toList();
    if (active.isEmpty) return;
    final chosen = await showDialog<Promotion>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Select Promotion'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: active.length,
            itemBuilder: (_, i) {
              final promo = active[i];
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
    if (chosen != null) setState(() => _selectedPromo = chosen);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fieldMap = (IndustryConfig.forIndustry(AppSession.instance.industryId ?? '')?['sessionFields'] as Map?)?.map(
          (k, v) => MapEntry(k.toString(), v.toString()),
        ) ?? {};

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Billing Summary'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (r) => false),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            OrderMetaDisplay(
              style: const TextStyle(fontSize: 14, color: Colors.black),
              sessionData: AppSession.instance.sessionData.map((k, v) => MapEntry(k, v.toString())),
              sessionLabels: fieldMap,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: Container(
                    constraints: const BoxConstraints(minHeight: 48),
                    child: CustomerSearchDropdown(
                      onCustomerSelected: (c) => setState(() => _selectedCustomer = c),
                    ),
                  )
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
            if (_selectedCustomer != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_selectedCustomer!.name, style: theme.textTheme.titleSmall),
                        Text('${_selectedCustomer!.phone} | ${_selectedCustomer!.email ?? ''}'),
                        Text(_selectedCustomer!.address ?? ''),
                        Text('${_selectedCustomer!.state ?? ''} | GST: ${_selectedCustomer!.gst ?? ''}'),
                      ],
                    ),
                  ),
                ),
              ),

            if (_selectedPromo != null)
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.green, size: 18),
                    const SizedBox(width: 2),
                    Text(
                      'Promo: ${_selectedPromo!.title} (${_selectedPromo!.discountPercentage.toStringAsFixed(1)}%)',
                      style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close_rounded, color: Colors.red, size: 18),
                      onPressed: () => setState(() => _selectedPromo = null),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
            TextButton(
              onPressed: _applyPromotion,
              child: const Text('View All Promotions'),
            ),
            const Divider(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ...widget.cartItems.entries.map((e) {
                    final price = e.value['price'] as double;
                    final qty = e.value['qty'] as int;
                    return ListTile(
                      dense: true,
                      title: Text(e.key, style: theme.textTheme.titleMedium),
                      subtitle: Text('₹${formatter.format(price)} x $qty'),
                    );
                  }),
                ],
              ),
            ),
            const Divider(),
            Column(
              children: [
                _buildRow(context, 'Subtotal', _subtotal),
                if (_cgst > 0) _buildRow(context, 'CGST', _cgst),
                if (_sgst > 0) _buildRow(context, 'SGST', _sgst),
                if (_igst > 0) _buildRow(context, 'IGST', _igst),
                if (_discount > 0 && _selectedPromo != null)
                  _buildRow(context,
                      'Discount (${_selectedPromo!.title} ${_selectedPromo!.discountPercentage.toStringAsFixed(1)}%)', -_discount),
                const Divider(),
                _buildRow(context, 'Total', _total, isTotal: true),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: Container(
                color: theme.cardColor,
                padding: const EdgeInsets.symmetric(horizontal: 12),
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
                      Text(_selectedPayment ?? 'Payment'),
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
                    ? _confirmAndSave
                    : null,
                child: Text('Pay ₹${formatter.format(_total)}'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
