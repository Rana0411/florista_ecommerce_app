import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class HomeSection<T> extends StatelessWidget {
  const HomeSection({
    super.key,
    required this.title,
    required this.items,
    required this.itemBuilder,
    this.onViewAll,
    this.height = 90,
  });

  final String title;
  final List<T> items;
  final Widget Function(T item) itemBuilder;
  final VoidCallback? onViewAll;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),

            TextButton(
              onPressed: onViewAll,
              child: Text(
                S.current.viewAll,
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primary,
                ),
              ),
            ),
          ],
        ),

        /// Horizontal List
        SizedBox(
          height: height,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return itemBuilder(items[index]);
            },
          ),
        ),
      ],
    );
  }
}
