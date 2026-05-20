import 'dart:io';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/assets_manager.dart';
import 'package:florista_ecommerce_app/features/edit_profile/presentation/view_model/cubit/edit_profile_event.dart';
import 'package:florista_ecommerce_app/features/edit_profile/presentation/view_model/cubit/edit_profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileImageStack extends StatelessWidget {
  const EditProfileImageStack({super.key, required this.photo});

  final String? photo;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileViewModel, EditProfileState>(
      buildWhen: (prev, curr) =>
          prev.pickedPhotoPath != curr.pickedPhotoPath ||
          prev.uploadProfilePhotoState.isLoading !=
              curr.uploadProfilePhotoState.isLoading,
      builder: (context, state) {
        ImageProvider imageProvider;
        if (state.pickedPhotoPath != null) {
          imageProvider = FileImage(File(state.pickedPhotoPath!));
        } else if (photo?.isNotEmpty == true) {
          imageProvider = NetworkImage(photo!);
        } else {
          imageProvider = const AssetImage(AssetsManager.logo);
        }

        return Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(radius: 50, backgroundImage: imageProvider),

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

                child: state.uploadProfilePhotoState.isLoading == true
                    ? const Padding(
                        padding: EdgeInsets.all(6),
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : IconButton(
                        color: AppColors.black,
                        iconSize: 16,
                        onPressed: () {
                          context.read<EditProfileViewModel>().doEvent(
                            PickProfilePhoto(),
                          );
                        },
                        icon: const Icon(Icons.camera_alt_outlined),
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}
