// lib/widgets/order_meta_display.dart

import 'package:flutter/material.dart';

class OrderMetaDisplay extends StatelessWidget {
  final Map<String, String>? sessionData;
  final Map<String, String>? sessionLabels;
  final TextStyle? style;

  const OrderMetaDisplay({
    Key? key,
    this.sessionData,
    this.sessionLabels,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (sessionData == null || sessionLabels == null || sessionData!.isEmpty || sessionLabels!.isEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: sessionLabels!.entries.map((entry) {
            final value = sessionData![entry.key] ?? '';
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Text('${entry.value}: $value', style: style ?? const TextStyle(fontSize: 12, color: Colors.grey)),
            );
          }).toList(),
        ),
      ),
    );
  }
}
