import 'package:florista_ecommerce_app/config/shared_models/user_data/user_request_dto.dart';
import 'package:florista_ecommerce_app/config/text_field_validator.dart';
import 'package:florista_ecommerce_app/core/router/nav_helper.dart';
import 'package:florista_ecommerce_app/core/shared_widgets/custom_buttom_navigation_bar.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/core/utils/responsive/screen_size.dart';
import 'package:florista_ecommerce_app/features/edit_profile/presentation/widgets/edit_profile_image_stack.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key, required this.user});
  final UserRequestDto user;

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String? gender;

  @override
  void initState() {
    super.initState();
    gender = widget.user.gender ?? 'male';
  }

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        leadingWidth: 20,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Edit profile"), Icon(Icons.notifications_outlined)],
        ),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              spacing: 24,
              children: [
                EditProfileImageStack(photo: widget.user.photo),

                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    SizedBox(
                      width: ScreenSize.w(context, 0.43),

                      // First name
                      child: TextFormField(
                        cursorColor: AppColors.black,
                        decoration: InputDecoration(labelText: "First name"),
                        validator: (value) {
                          return AppTextFieldValidator.validateName(value);
                        },
                      ),
                    ),

                    // Last name
                    SizedBox(
                      width: ScreenSize.w(context, 0.43),
                      child: TextFormField(
                        cursorColor: AppColors.black,
                        decoration: InputDecoration(labelText: "Last name"),
                        validator: (value) {
                          return AppTextFieldValidator.validateName(value);
                        },
                      ),
                    ),
                  ],
                ),

                // Email
                TextFormField(
                  cursorColor: AppColors.black,
                  decoration: InputDecoration(labelText: "Email"),
                  validator: (value) {
                    return AppTextFieldValidator.validateEmail(value);
                  },
                ),

                // Phone number
                TextFormField(
                  cursorColor: AppColors.black,
                  decoration: InputDecoration(labelText: "Phone number"),
                  validator: (value) {
                    return AppTextFieldValidator.validatePhone(value);
                  },
                ),

                // Password
                TextFormField(
                  enabled: false,
                  cursorColor: AppColors.black,
                  obscureText: true,
                  obscuringCharacter: '*',
                  validator: (value) {
                    return AppTextFieldValidator.validatePassword(value);
                  },
                  decoration: InputDecoration(
                    labelText: "Password",
                    suffixIcon: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size(70, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                      child: Text(
                        'Change',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeightManager.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                RadioGroup<String>(
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value;
                    });
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 40),
                        child: Text("Gender", style: TextStyle(fontSize: 18)),
                      ),
                      SizedBox(
                        width: ScreenSize.w(context, .32),
                        child: RadioListTile<String>(
                          title: const Text("Female"),
                          value: "female",
                          horizontalTitleGap: 0,
                        ),
                      ),
                      SizedBox(
                        width: ScreenSize.w(context, .32),
                        child: RadioListTile<String>(
                          title: const Text("Male"),
                          value: "male",
                          horizontalTitleGap: 0,
                          fillColor: WidgetStatePropertyAll(AppColors.primary),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 48),

                SizedBox(
                  width: ScreenSize.w(context, 1),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                    child: Text("Update"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: NavHelper.getCurrentIndex(location),
        onTap: (index) => NavHelper.onItemTapped(context, index),
      ),
    );
  }
}
