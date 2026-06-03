import 'package:florista_ecommerce_app/core/utils/responsive/screen_size.dart';
import 'package:florista_ecommerce_app/features/edit_profile/presentation/view_model/cubit/edit_profile_view_model.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileUpdateButton extends StatelessWidget {
  const EditProfileUpdateButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileViewModel, EditProfileState>(
      buildWhen: (prev, curr) =>
          prev.editProfileState.isLoading != curr.editProfileState.isLoading,
      builder: (context, state) {
        return SizedBox(
          width: ScreenSize.w(context, 1),
          child: ElevatedButton(
            onPressed: state.editProfileState.isLoading == true
                ? null
                : onPressed,
            child: state.editProfileState.isLoading == true
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(S.current.update),
          ),
        );
      },
    );
  }
}
