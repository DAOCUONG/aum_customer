import 'package:flutter/material.dart';

/// CheckoutButton - Full-width checkout button
class CheckoutButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CheckoutButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Container(width: 80, height: 8, decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(4))),
        ),
      ),
    );
  }
}
