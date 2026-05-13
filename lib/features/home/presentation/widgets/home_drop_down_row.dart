import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class HomeDropDownRow extends StatelessWidget {
  const HomeDropDownRow({
    super.key,
    required this.selectedLocation,
    required this.items,
  });

  final String selectedLocation;
  final List<DropdownMenuItem<String>>? items;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.place_outlined, color: AppColors.grey, size: 22),

        const SizedBox(width: 6),

        DropdownButton<String>(
          value: selectedLocation,
          items: items,

          onChanged: (value) {},

          icon: const Icon(Icons.keyboard_arrow_down),
          iconSize: 24,
          iconEnabledColor: AppColors.primary,
          iconDisabledColor: AppColors.lightGrey,

          underline: const SizedBox(),
          isDense: true,
        ),
      ],
    );
  }
}
