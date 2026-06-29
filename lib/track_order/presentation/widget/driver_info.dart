import 'package:flutter/material.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';

class DriverInfoCard extends StatelessWidget {
  final String driverName;
  final String driverPhone;
  final VoidCallback onCall;
  final VoidCallback onText;

  const DriverInfoCard({
    super.key,
    required this.driverName,
    required this.driverPhone,
    required this.onCall,
    required this.onText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: const AssetImage('assets/images/Delivery Boy.png'),
            backgroundColor: AppColors.primary.withOpacity(0.1),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  driverName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFonts.interFamily,
                  ),
                ),
                Text(
                  S.of(context).isYourDeliveryHeroForToday,
                  style: TextStyle(
                    color: AppColors.grey,
                    fontFamily: AppFonts.interFamily,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: onCall,
                icon: Icon(Icons.phone, color: AppColors.primary),
              ),
              IconButton(
                onPressed: onText,
                icon: Image.asset(
                  'assets/images/whatsapp.png',
                  width: 24,
                  height: 24,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}