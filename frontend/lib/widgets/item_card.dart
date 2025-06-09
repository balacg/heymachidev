// lib/widgets/item_card.dart

import 'package:flutter/material.dart';

class ItemCard extends StatefulWidget {
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final int initialQty;
  final Function(int) onQtyChanged;

  const ItemCard({
    super.key,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.onQtyChanged,
    this.initialQty = 0,
  });

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  late int _qty;

  @override
  void initState() {
    super.initState();
    _qty = widget.initialQty;
  }

  void _add() {
    setState(() {
      _qty = 1;
    });
    widget.onQtyChanged(_qty);
  }

  void _increment() {
    setState(() {
      _qty++;
    });
    widget.onQtyChanged(_qty);
  }

  void _decrement() {
    setState(() {
      _qty--;
    });
    widget.onQtyChanged(_qty);
  }

  @override
  void didUpdateWidget(covariant ItemCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialQty != oldWidget.initialQty) {
      setState(() {
        _qty = widget.initialQty;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[800],
              ),
              child: widget.imageUrl.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        widget.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, _) {
                          return const Icon(Icons.broken_image, color: Colors.grey);
                        },
                      ),
                    )
                  : const Icon(Icons.image_not_supported, color: Colors.grey),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                  const SizedBox(height: 2),
                  Text(widget.description,
                      style: const TextStyle(fontSize: 13, color: Colors.grey)),
                  const SizedBox(height: 6),
                  Text("₹${widget.price.toStringAsFixed(0)}",
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                ],
              ),
            ),
            const SizedBox(width: 12),
            _qty == 0
                ? ElevatedButton(
                    onPressed: _add,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                    ),
                    child: const Text("ADD"),
                  )
                : Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove, color: Colors.white),
                          onPressed: () {
                            if (_qty == 1) {
                              setState(() => _qty = 0);
                              widget.onQtyChanged(0);
                            } else {
                              _decrement();
                            }
                          },
                        ),
                        Text(
                          '$_qty',
                          style: const TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add, color: Colors.white),
                          onPressed: _increment,
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
