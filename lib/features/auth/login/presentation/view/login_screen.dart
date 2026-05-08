import 'package:florista_ecommerce_app/config/base_state/base_state.dart';
import 'package:florista_ecommerce_app/config/text_field_validator.dart';
import 'package:florista_ecommerce_app/core/router/route_path.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/features/auth/login/domain/entity/login_entity.dart';
import 'package:florista_ecommerce_app/features/auth/login/presentation/screen/login_screen.dart';
import 'package:florista_ecommerce_app/features/auth/login/presentation/widget/login_form_section.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../widget/buttons/guest_button.dart';
import '../widget/buttons/login_button.dart';
import '../widget/buttons/signup_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<LoginCubit>().login(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    }
  }

  void _onStateChanged(
      BuildContext context,
      BaseState<LoginEntity> state,
      ) {
    if (state.data != null) {
      context.go(RoutePath.home);
      return;
    }

    if (state.errorMessage != null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(state.errorMessage!),
            backgroundColor: AppColors.error,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final mq = MediaQuery.of(context);
    final screenH = mq.size.height;
    final screenW = mq.size.width;
    final keyboardH = mq.viewInsets.bottom;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          l10n.login,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: BlocConsumer<LoginCubit, BaseState<LoginEntity>>(
        listener: _onStateChanged,
        builder: (context, state) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final isTablet = constraints.maxWidth >= 600;
              final hPad = isTablet ? screenW * 0.15 : screenW * 0.05;

              return SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: hPad,
                  right: hPad,
                  top: screenH * 0.02,
                  bottom: keyboardH + screenH * 0.02,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: screenH * 0.03),
                        LoginFormSection(
                          formKey: _formKey,
                          emailController: _emailController,
                          passwordController: _passwordController,
                          emailValidator: AppTextFieldValidator.validateEmail,
                          passwordValidator:
                          AppTextFieldValidator.validatePassword,
                          rememberMe: _rememberMe,
                          onRememberMeChanged: (v) {
                            setState(() => _rememberMe = v ?? false);
                          },
                        ),
                        SizedBox(height: screenH * 0.05),
                        LoginButton(
                          isLoading: state.isLoading ?? false,
                          onPressed: _onLoginPressed,
                          label: l10n.login,
                          height: screenH * 0.065,
                        ),
                        SizedBox(height: screenH * 0.03),
                        GuestButton(
                          label: l10n.continueAsGuest,
                          onPressed: () => context.go(RoutePath.home),
                          height: screenH * 0.065,
                        ),
                        SizedBox(height: screenH * 0.02),
                        SignUpRow(
                          noAccountText: l10n.dontHaveAccount,
                          signUpText: l10n.signUp,
                          onSignUpTap: () => context.push(RoutePath.signup),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
