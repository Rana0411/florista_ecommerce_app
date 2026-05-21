import 'package:florista_ecommerce_app/config/text_field_validator.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/responsive/screen_size.dart';
import 'package:florista_ecommerce_app/features/change_password/data/models/change_password_request.dart';
import 'package:florista_ecommerce_app/features/change_password/presentation/view_model/cubit/change_password_event.dart';
import 'package:florista_ecommerce_app/features/change_password/presentation/view_model/cubit/change_password_view_model.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        title: Text(S.current.changePassword),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              spacing: 24,
              children: [
                BlocBuilder<ChangePasswordViewModel, ChangePasswordState>(
                  buildWhen: (prev, curr) =>
                      prev.changePasswordState != curr.changePasswordState,
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          cursorColor: AppColors.black,
                          controller: _currentPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: S.current.currentPassword,
                            hintText: S.current.currentPassword,
                          ),
                          validator: AppTextFieldValidator.validatePassword,
                        ),

                        if (state.changePasswordState.errorMessage != null &&
                            state.changePasswordState.isLoading != true)
                          Padding(
                            padding: const EdgeInsets.only(top: 6, left: 12),
                            child: Text(
                              state.changePasswordState.errorMessage!,
                              style: Theme.of(context).textTheme.bodySmall!
                                  .copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                            ),
                          ),
                      ],
                    );
                  },
                ),

                TextFormField(
                  cursorColor: AppColors.black,
                  controller: _newPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: S.current.newPassword,
                    hintText: S.current.newPassword,
                  ),
                  validator: AppTextFieldValidator.validatePassword,
                ),

                TextFormField(
                  cursorColor: AppColors.black,
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: S.current.confirmPassword,
                    hintText: S.current.confirmPassword,
                  ),
                  validator: (value) =>
                      AppTextFieldValidator.validateConfirmPassword(
                        value,
                        _newPasswordController.text,
                      ),
                ),

                const SizedBox(height: 24),

                BlocConsumer<ChangePasswordViewModel, ChangePasswordState>(
                  listenWhen: (prev, curr) =>
                      prev.changePasswordState != curr.changePasswordState,
                  listener: (context, state) {
                    if (state.changePasswordState.isLoading != true &&
                        state.changePasswordState.data != null &&
                        state.changePasswordState.errorMessage == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.changePasswordState.data?.message ??
                                S.current.passwordChangedSuccessfully,
                          ),
                          backgroundColor: AppColors.green,
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  buildWhen: (prev, curr) =>
                      prev.changePasswordState.isLoading !=
                      curr.changePasswordState.isLoading,
                  builder: (context, state) {
                    return SizedBox(
                      width: ScreenSize.w(context, 1),
                      child: ElevatedButton(
                        onPressed: state.changePasswordState.isLoading == true
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  context
                                      .read<ChangePasswordViewModel>()
                                      .doEvent(
                                        ChangePasswordEvent(
                                          passwords: ChangePasswordRequest(
                                            password: _currentPasswordController
                                                .text
                                                .trim(),
                                            newPassword: _newPasswordController
                                                .text
                                                .trim(),
                                          ),
                                        ),
                                      );
                                }
                              },
                        child: state.changePasswordState.isLoading == true
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(S.current.update),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
