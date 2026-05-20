import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/responsive/screen_size.dart';
import 'package:florista_ecommerce_app/features/edit_profile/presentation/view_model/cubit/edit_profile_event.dart';
import 'package:florista_ecommerce_app/features/edit_profile/presentation/view_model/cubit/edit_profile_view_model.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenderRadioGroup extends StatelessWidget {
  const GenderRadioGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileViewModel, EditProfileState>(
      buildWhen: (prev, curr) => prev.gender != curr.gender,
      builder: (context, state) {
        return RadioGroup<String>(
          groupValue: state.gender,
          onChanged: (value) {
            if (value != null) {
              context.read<EditProfileViewModel>().doEvent(
                UpdateGender(gender: value),
              );
            }
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Text(
                  S.current.gender,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(
                width: ScreenSize.w(context, .34),
                child: RadioListTile<String>(
                  title: Text(S.current.female),
                  value: "female",
                  horizontalTitleGap: 0,
                  fillColor: WidgetStatePropertyAll(AppColors.primary),
                ),
              ),
              SizedBox(
                width: ScreenSize.w(context, .30),
                child: RadioListTile<String>(
                  title: Text(S.current.male),
                  value: "male",
                  horizontalTitleGap: 0,
                  fillColor: WidgetStatePropertyAll(AppColors.primary),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
