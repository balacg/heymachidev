import 'package:flutter/material.dart';
import 'package:heymachi_dev/utils/app_session.dart';
import 'package:restaurant_addon/constants/dining_types.dart';

/// Collects diningType, tableNo and pax, then returns them via pop().
class DiningSelectorPage extends StatefulWidget {
  const DiningSelectorPage({Key? key}) : super(key: key);
  @override
  State<DiningSelectorPage> createState() => _DiningSelectorPageState();
}

class _DiningSelectorPageState extends State<DiningSelectorPage> {
  String? selectedType;
  String? selectedTable;
  int pax = 1;

  // T1, T2 ... T12
  final List<String> tables = List.generate(12, (i) => 'T${i + 1}');

  void selectDiningType(String type) {
    setState(() {
      selectedType = type;
      if (type != DiningTypes.dineIn) {
        selectedTable = null;
        pax = 1;
      }
    });
  }

  void _confirm() {
    final data = {
      'diningType': selectedType,
      'tableNo': selectedTable,
      'pax': pax,
    };
    // stash it for header
    AppSession.instance.sessionData = data;
    // pop out with result
    Navigator.pop(context, data);
  }

  @override
  Widget build(BuildContext context) {
    final isDineIn = selectedType == DiningTypes.dineIn;
    return Scaffold(
      appBar: AppBar(title: const Text('Select Dining Mode')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Choose Dining Type:', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ['Dine-In', 'Takeaway', 'Delivery'].map((type) {
                final icon = type == DiningTypes.dineIn
                    ? Icons.restaurant
                    : type == DiningTypes.takeaway
                        ? Icons.shopping_bag
                        : Icons.delivery_dining;
                final sel = selectedType == type;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ElevatedButton.icon(
                      icon: Icon(icon, color: sel ? Colors.white : Colors.blueGrey),
                      label: Text(type, style: TextStyle(
                        color: sel ? Colors.white : Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                      )),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: sel ? Colors.blue : Colors.grey[200],
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () => selectDiningType(type),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            if (isDineIn) ...[
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Select Table:', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.3,
                  children: tables.map((t) {
                    final sel = t == selectedTable;
                    return GestureDetector(
                      onTap: () => setState(() => selectedTable = t),
                      child: Card(
                        color: sel ? Colors.blue : Colors.grey[200],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Text(t,
                              style: TextStyle(
                                color: sel ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No. of People: '),
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: pax > 1 ? () => setState(() => pax--) : null,
                  ),
                  Text('$pax', style: const TextStyle(fontSize: 16)),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: () => setState(() => pax++),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: selectedType == null || (isDineIn && selectedTable == null)
                  ? null
                  : _confirm,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              ),
              child: const Text('Continue to Billing'),
            ),
          ],
        ),
      ),
    );
  }
}
