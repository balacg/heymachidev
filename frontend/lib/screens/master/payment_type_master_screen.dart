//lib/screens/master/payment_type_master_screen.dart

import 'package:flutter/material.dart';
import '../../models/payment_type.dart';
import '../../services/payment_type_service.dart';

class PaymentTypeMasterScreen extends StatefulWidget {
  const PaymentTypeMasterScreen({Key? key}) : super(key: key);

  @override
  State<PaymentTypeMasterScreen> createState() => _PaymentTypeMasterScreenState();
}

class _PaymentTypeMasterScreenState extends State<PaymentTypeMasterScreen> {
  List<PaymentType> _types = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    _types = await PaymentTypeService.getAll();
    setState(() {});
  }

  void _addOrEdit([PaymentType? existing]) {
    final ctrl = TextEditingController(text: existing?.name);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(existing == null ? 'Add Payment Type' : 'Edit Payment Type'),
        content: TextField(controller: ctrl, decoration: const InputDecoration(labelText: 'Name')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              final name = ctrl.text.trim();
              if (name.isEmpty) return;
              await PaymentTypeService.upsert(
                existing == null ? PaymentType(id: '', name: name) : PaymentType(id: existing.id, name: name),
              );
              Navigator.pop(context);
              _load();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _delete(String id) async {
    await PaymentTypeService.delete(id);
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Types')),
      body: ListView.builder(
        itemCount: _types.length,
        itemBuilder: (_, idx) {
          final pt = _types[idx];
          return ListTile(
            title: Text(pt.name),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              IconButton(icon: const Icon(Icons.edit), onPressed: () => _addOrEdit(pt)),
              IconButton(icon: const Icon(Icons.delete), onPressed: () => _delete(pt.id)),
            ]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEdit(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
