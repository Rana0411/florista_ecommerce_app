import 'package:florista_ecommerce_app/config/shared_models/user_data/user_request_dto.dart';
import 'package:florista_ecommerce_app/config/text_field_validator.dart';
import 'package:florista_ecommerce_app/core/router/nav_helper.dart';
import 'package:florista_ecommerce_app/core/router/route_path.dart';
import 'package:florista_ecommerce_app/core/shared_widgets/custom_buttom_navigation_bar.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/core/utils/responsive/screen_size.dart';
import 'package:florista_ecommerce_app/features/edit_profile/presentation/view_model/cubit/edit_profile_event.dart';
import 'package:florista_ecommerce_app/features/edit_profile/presentation/view_model/cubit/edit_profile_view_model.dart';
import 'package:florista_ecommerce_app/features/edit_profile/presentation/widgets/edit_profile_image_stack.dart';
import 'package:florista_ecommerce_app/features/edit_profile/presentation/widgets/edit_profile_update_button.dart';
import 'package:florista_ecommerce_app/features/edit_profile/presentation/widgets/gender_radio_group.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key, required this.user});
  final UserRequestDto user;

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(
      text: widget.user.firstName ?? '',
    );
    _lastNameController = TextEditingController(
      text: widget.user.lastName ?? '',
    );
    _emailController = TextEditingController(text: widget.user.email ?? '');
    _phoneController = TextEditingController(text: widget.user.phone ?? '');

    context.read<EditProfileViewModel>().initUser(widget.user);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _onUpdate() {
    if (!_formKey.currentState!.validate()) return;

    final cubit = context.read<EditProfileViewModel>();
    final changedDto = cubit.buildChangedDto(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
    );

    cubit.doEvent(UploadProfileData(user: changedDto));
  }

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    return BlocListener<EditProfileViewModel, EditProfileState>(
      listenWhen: (prev, curr) =>
          prev.editProfileState != curr.editProfileState,
      listener: (context, state) {
        if (state.editProfileState.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.editProfileState.errorMessage!),
              backgroundColor: AppColors.error,
            ),
          );
        }
        if (state.editProfileState.data != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(S.current.profileUpdatedSuccessfully),
              backgroundColor: AppColors.green,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios),
          ),
          leadingWidth: 20,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(S.current.editProfile),
              Icon(Icons.notifications_outlined),
            ],
          ),
        ),
        body: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                spacing: 24,
                children: [
                  EditProfileImageStack(photo: widget.user.photo),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: ScreenSize.w(context, 0.43),
                        child: TextFormField(
                          controller: _firstNameController,
                          cursorColor: AppColors.black,
                          decoration: InputDecoration(
                            labelText: S.current.firstName,
                          ),
                          validator: AppTextFieldValidator.validateName,
                        ),
                      ),
                      SizedBox(
                        width: ScreenSize.w(context, 0.43),
                        child: TextFormField(
                          controller: _lastNameController,
                          cursorColor: AppColors.black,
                          decoration: InputDecoration(
                            labelText: S.current.lastName,
                          ),
                          validator: AppTextFieldValidator.validateName,
                        ),
                      ),
                    ],
                  ),

                  TextFormField(
                    controller: _emailController,
                    cursorColor: AppColors.black,
                    decoration: InputDecoration(labelText: S.current.email),
                    validator: AppTextFieldValidator.validateEmail,
                  ),

                  TextFormField(
                    controller: _phoneController,
                    cursorColor: AppColors.black,
                    decoration: InputDecoration(
                      labelText: S.current.phoneNumber,
                    ),
                    validator: AppTextFieldValidator.validatePhone,
                  ),

                  TextFormField(
                    enabled: false,
                    cursorColor: AppColors.black,
                    obscureText: true,
                    obscuringCharacter: '*',
                    initialValue: '********',
                    decoration: InputDecoration(
                      labelText: S.current.password,
                      suffixIcon: TextButton(
                        onPressed: () {
                          context.push(RoutePath.changePassword);
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(70, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                        ),
                        child: Text(
                          S.current.change,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeightManager.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const GenderRadioGroup(),

                  const SizedBox(height: 48),

                  EditProfileUpdateButton(onPressed: _onUpdate),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: NavHelper.getCurrentIndex(location),
          onTap: (index) => NavHelper.onItemTapped(context, index),
        ),
      ),
    );
  }
}
