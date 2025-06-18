import 'package:flutter/material.dart';

class ExpandableFab extends StatefulWidget {
  final double distance;
  final List<Widget> children;

  const ExpandableFab({super.key, required this.distance, required this.children});

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;

  bool _open = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 250));
    _expandAnimation = CurvedAnimation(curve: Curves.easeOut, parent: _controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          ...List.generate(widget.children.length, (i) {
            final angle = 90.0 * i / (widget.children.length - 1);
            final rad = angle * (3.1416 / 180);
            return AnimatedBuilder(
              animation: _expandAnimation,
              builder: (context, child) {
                final offset = Offset.fromDirection(rad, _expandAnimation.value * widget.distance);
                return Positioned(
                  right: 16 + offset.dx,
                  bottom: 16 + offset.dy,
                  child: FadeTransition(opacity: _expandAnimation, child: child),
                );
              },
              child: widget.children[i],
            );
          }),
          FloatingActionButton(
            onPressed: _toggle,
            child: Icon(_open ? Icons.close : Icons.add),
          ),
        ],
      ),
    );
  }
}
