import 'package:florista_ecommerce_app/config/di/di.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/text_field_validator.dart';
import '../../../../../generated/l10n.dart';
import '../view_model/sign_up_view_model.dart';
import '../widgets/sign_up_button.dart';
import '../widgets/sign_up_gender_row.dart';
import '../widgets/sign_up_login_redirect.dart';
import '../widgets/sign_up_name_row.dart';
import '../widgets/sign_up_password_row.dart';
import '../widgets/sign_up_terms_text.dart';
import '../widgets/sign_up_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();

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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select gender')),
      );
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
        listener: _onStateChange,
        builder: (context, state) {
          final isLoading = state.signUpState.isLoading == true;

          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back_ios, color: textTheme.bodyMedium?.color),
              ),
              title: Text(S.of(context).signUp, style: textTheme.headlineMedium),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SignUpNameRow(
                        firstNameController: firstNameController,
                        lastNameController: lastNameController,
                      ),
                      const SizedBox(height: 18),
                      SignUpTextField(
                        controller: emailController,
                        label: S.of(context).email,
                        hint: S.of(context).enterYourEmail,
                        keyboardType: TextInputType.emailAddress,
                        validator: AppTextFieldValidator.validateEmail,
                      ),
                      const SizedBox(height: 18),
                      SignUpPasswordRow(
                        passwordController: passwordController,
                        confirmPasswordController: confirmPasswordController,
                      ),
                      const SizedBox(height: 18),
                      SignUpTextField(
                        controller: phoneController,
                        label: S.of(context).phoneNumber,
                        hint: S.of(context).enterPhoneNumber,
                        keyboardType: TextInputType.phone,
                        validator: AppTextFieldValidator.validatePhone,
                      ),
                      const SizedBox(height: 28),
                      SignUpGenderRow(
                        gender: gender,
                        onChanged: (value) => setState(() => gender = value),
                      ),
                      const SizedBox(height: 18),
                      const SignUpTermsText(),
                      const SizedBox(height: 48),
                      SignUpButton(
                        isLoading: isLoading,
                        onPressed: () => _onSignUp(context),
                      ),
                      const SizedBox(height: 20),
                      const SignUpLoginRedirect(),
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

  void _onStateChange(BuildContext context, SignUpState state) {
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
      // TODO: navigate to home
    }
  }
}
