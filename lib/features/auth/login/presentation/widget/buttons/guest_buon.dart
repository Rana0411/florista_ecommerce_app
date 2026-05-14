import 'package:flutter/material.dart';

class GuestButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double height;

  const GuestButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
