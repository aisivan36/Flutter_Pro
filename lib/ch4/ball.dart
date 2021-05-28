import 'package:flutter/material.dart';

class Ball extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double diam = 50;
    return Container(
      width: diam,
      height: diam,
      decoration: const BoxDecoration(
        color: const Color(0xFFFFCA28),
        shape: BoxShape.circle,
      ),
    );
  }
}
