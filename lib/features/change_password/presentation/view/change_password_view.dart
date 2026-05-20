import 'package:florista_ecommerce_app/config/text_field_validator.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/responsive/screen_size.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        leadingWidth: 20,
        title: Text("Change password"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 24,
              children: [
                TextFormField(
                  cursorColor: AppColors.black,
                  controller: _currentPasswordController,
                  decoration: InputDecoration(
                    labelText: "Current password",
                    hintText: "Current password",
                  ),
                  validator: AppTextFieldValidator.validatePassword,
                ),
                TextFormField(
                  cursorColor: AppColors.black,
                  controller: _newPasswordController,
                  decoration: InputDecoration(
                    labelText: "New password",
                    hintText: "New password",
                  ),
                  validator: AppTextFieldValidator.validatePassword,
                ),
                TextFormField(
                  cursorColor: AppColors.black,
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: "Confirm password",
                    hintText: "Confirm password",
                  ),
                  validator: (value) {
                    final String newPassword = _newPasswordController.text;
                    return AppTextFieldValidator.validateConfirmPassword(
                      value,
                      newPassword,
                    );
                  },
                ),

                SizedBox(height: 24),

                SizedBox(
                  width: ScreenSize.w(context, 1),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(S.current.update),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
