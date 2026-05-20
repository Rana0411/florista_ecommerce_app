import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';

class EditProfileImageStack extends StatelessWidget {
  const EditProfileImageStack({super.key, required this.photo});

  final String? photo;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: photo?.isNotEmpty == true
              ? NetworkImage(photo!)
              : const AssetImage(AssetsManager.logo) as ImageProvider,
        ),
        Positioned(
          right: -10,
          bottom: -1,
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            child: IconButton(
              color: AppColors.black,
              iconSize: 16,
              onPressed: () {},
              icon: Icon(Icons.camera_alt_outlined),
            ),
          ),
        ),
      ],
    );
  }
}
