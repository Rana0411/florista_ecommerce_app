import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: [
          IconButton(
            padding: EdgeInsets.all(0),
            onPressed: () {},
            icon: Icon(Icons.toggle_on, color: AppColors.primary, size: 40),
          ),
          Text(
            S.current.notification,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 13,
              fontWeight: FontWeightManager.regular,
            ),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios, size: 24, color: AppColors.lightGrey),
        ],
      ),
    );
  }
}
