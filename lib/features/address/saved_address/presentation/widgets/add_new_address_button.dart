import 'package:florista_ecommerce_app/core/utils/responsive/screen_size.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class AddNewAddressButton extends StatelessWidget {
  const AddNewAddressButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenSize.w(context, 1),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text('add new address'),
      ),
    );
  }
}
