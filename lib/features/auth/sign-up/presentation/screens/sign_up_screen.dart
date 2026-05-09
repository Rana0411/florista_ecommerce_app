import 'package:florista_ecommerce_app/config/di/di.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/text_field_validator.dart';
import '../../../../../generated/l10n.dart';
import '../view_model/sign_up_view_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  String gender = '';

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();

    super.dispose();
  }

  void _onSignUp(BuildContext context) {
    if (gender.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select gender')));
      return;
    }

    if (_formKey.currentState!.validate()) {
      context.read<SignUpViewModel>().signUp(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        rePassword: confirmPasswordController.text.trim(),
        phone: phoneController.text.trim(),
        gender: gender,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocProvider(
      create: (_) => getIt<SignUpViewModel>(),

      child: BlocConsumer<SignUpViewModel, SignUpState>(
        listener: (context, state) {
          if (state.signUpState.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.signUpState.errorMessage!),
                backgroundColor: Colors.red,
              ),
            );

            context.read<SignUpViewModel>().clearError();
          }

          if (state.signUpState.data != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(S.of(context).signUpSuccess)),
            );

            /// TODO navigate
          }
        },

        builder: (context, state) {
          final isLoading = state.signUpState.isLoading == true;

          return Scaffold(
            appBar: AppBar(
              elevation: 0,

              leading: IconButton(
                onPressed: () => Navigator.pop(context),

                icon: Icon(
                  Icons.arrow_back_ios,
                  color: textTheme.bodyMedium?.color,
                ),
              ),

              title: Text(
                S.of(context).signUp,
                style: textTheme.headlineMedium,
              ),
            ),

            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),

                child: Form(
                  key: _formKey,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              controller: firstNameController,

                              label: S.of(context).firstName,

                              hint: S.of(context).enterFirstName,

                              validator: AppValidator.validateName,
                            ),
                          ),

                          const SizedBox(width: 14),

                          Expanded(
                            child: _buildTextField(
                              controller: lastNameController,

                              label: S.of(context).lastName,

                              hint: S.of(context).enterLastName,

                              validator: AppValidator.validateName,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      _buildTextField(
                        controller: emailController,

                        label: S.of(context).email,

                        hint: S.of(context).enterYourEmail,

                        keyboardType: TextInputType.emailAddress,

                        validator: AppValidator.validateEmail,
                      ),

                      const SizedBox(height: 18),

                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              controller: passwordController,

                              label: S.of(context).password,

                              hint: S.of(context).enterPassword,

                              isPassword: true,

                              validator: AppValidator.validatePassword,
                            ),
                          ),

                          const SizedBox(width: 14),

                          Expanded(
                            child: _buildTextField(
                              controller: confirmPasswordController,

                              label: S.of(context).confirmPassword,

                              hint: S.of(context).confirmPassword,

                              isPassword: true,

                              validator: (value) {
                                return AppValidator.validateConfirmPassword(
                                  value,
                                  passwordController.text,
                                );
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      _buildTextField(
                        controller: phoneController,

                        label: S.of(context).phoneNumber,

                        hint: S.of(context).enterPhoneNumber,

                        keyboardType: TextInputType.phone,

                        validator: AppValidator.validatePhone,
                      ),

                      const SizedBox(height: 28),

                      Row(
                        children: [
                          Text(
                            S.of(context).gender,

                            style: textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          const SizedBox(width: 40),

                          Radio<String>(
                            value: 'female',

                            groupValue: gender,

                            activeColor: AppColors.primary,

                            onChanged: (value) {
                              setState(() {
                                gender = value!;
                              });
                            },
                          ),

                          Text(
                            S.of(context).female,
                            style: textTheme.bodyMedium,
                          ),

                          const SizedBox(width: 20),

                          Radio<String>(
                            value: 'male',

                            groupValue: gender,

                            activeColor: AppColors.primary,

                            onChanged: (value) {
                              setState(() {
                                gender = value!;
                              });
                            },
                          ),

                          Text(S.of(context).male, style: textTheme.bodyMedium),
                        ],
                      ),

                      const SizedBox(height: 18),

                      RichText(
                        text: TextSpan(
                          style: textTheme.bodyMedium?.copyWith(fontSize: 14),

                          children: [
                            TextSpan(
                              text: S
                                  .of(context)
                                  .creatingAnAccountYouAgreeToOur,
                            ),

                            TextSpan(
                              text: S.of(context).termsConditions,

                              style: textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.bold,

                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 48),

                      SizedBox(
                        width: double.infinity,
                        height: 56,

                        child: ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () => _onSignUp(context),

                          child: isLoading
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,

                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(S.of(context).signUp),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Center(
                        child: RichText(
                          text: TextSpan(
                            style: textTheme.bodyMedium,

                            children: [
                              TextSpan(
                                text: S.of(context).alreadyHaveAnAccount,
                              ),

                              TextSpan(
                                text: S.of(context).login,

                                style: textTheme.bodyMedium?.copyWith(
                                  color: AppColors.primary,

                                  decoration: TextDecoration.underline,

                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      validator: validator,

      decoration: InputDecoration(labelText: label, hintText: hint),
    );
  }
}
