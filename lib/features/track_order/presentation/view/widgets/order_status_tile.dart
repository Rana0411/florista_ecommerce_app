import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/core/utils/responsive/screen_size.dart';
import 'package:flutter/material.dart';

/// One row of the vertical tracking timeline: a status circle (with an
/// optional connecting line below it), a title and a timestamp.
///
/// Colors come from [AppColors] and text styles from the app's [Theme]
/// textTheme (`AppTextStyles.light`) for consistency with the rest of the
/// app.
class OrderStatusTile extends StatelessWidget {
  final String title;
  final String dateTime;
  final bool isActive;
  final bool isLast;

  const OrderStatusTile({
    super.key,
    required this.title,
    required this.dateTime,
    this.isActive = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              _StatusDot(isActive: isActive),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: AppColors.hintColor.withOpacity(0.3),
                  ),
                ),
            ],
          ),
          SizedBox(width: ScreenSize.w(context, 0.035)),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: ScreenSize.h(context, 0.027)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeightManager.semiBold,
                      fontSize: FontSize.s14,
                    ),
                  ),
                  SizedBox(height: ScreenSize.h(context, 0.005)),
                  Text(
                    dateTime,
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.hintColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusDot extends StatelessWidget {
  final bool isActive;

  const _StatusDot({required this.isActive});

  @override
  Widget build(BuildContext context) {
    if (isActive) {
      return Container(
        width: 20,
        height: 20,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.primary, width: 2),
        ),
        child: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary,
          ),
        ),
      );
    }

    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.hintColor.withOpacity(0.5),
          width: 2,
        ),
        color: AppColors.white,
      ),
    );
  }
}
