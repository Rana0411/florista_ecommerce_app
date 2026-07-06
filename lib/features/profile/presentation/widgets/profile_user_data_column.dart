import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/assets_manager.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/features/profile/presentation/view_model/profile_view_model.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileUserDataColumn extends StatelessWidget {
  const ProfileUserDataColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileViewModel, ProfileState>(
      builder: (context, state) {
        final userDataState = state.getUserDatastate;

        /// Loading State
        if (userDataState.isLoading == true) {
          return const Center(child: CircularProgressIndicator());
        }

        /// Error State
        if (userDataState.errorMessage != null) {
          return Center(
            child: Text(
              userDataState.errorMessage!,
              style: TextStyle(
                color: AppColors.error,
                fontSize: 16,
                fontWeight: FontWeightManager.medium,
              ),
            ),
          );
        }

        /// Empty State
        if (userDataState.data == null && userDataState.errorMessage == null) {
          return Center(child: Text(S.of(context).noUserData));
        }

        /// Data State
        final user = userDataState.data!;

        return Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: user.photo?.isNotEmpty == true
                  ? NetworkImage(user.photo!)
                  : const AssetImage(AssetsManager.logo) as ImageProvider,
            ),

            const SizedBox(height: 12),

            Text(
              user.firstName ?? S.of(context).noName,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18,
                fontWeight: FontWeightManager.medium,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              user.email ?? S.of(context).noEmail,
              style: TextStyle(
                color: AppColors.grey,
                fontSize: 18,
                fontWeight: FontWeightManager.medium,
              ),
            ),
          ],
        );
      },
    );
  }
}
