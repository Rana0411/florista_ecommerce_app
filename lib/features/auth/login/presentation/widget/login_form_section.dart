import 'package:florista_ecommerce_app/core/router/route_path.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/features/auth/login/presentation/widget/login_text_field.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginFormSection extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String? Function(String?) emailValidator;
  final String? Function(String?) passwordValidator;
  final bool rememberMe;
  final ValueChanged<bool?> onRememberMeChanged;

  const LoginFormSection({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.emailValidator,
    required this.passwordValidator,
    required this.rememberMe,
    required this.onRememberMeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final screenH = MediaQuery.of(context).size.height;

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LoginTextField(
            controller: emailController,
            label: l10n.email,
            hint: l10n.enterYourEmail,
            keyboardType: TextInputType.emailAddress,
            validator: emailValidator,
          ),
          SizedBox(height: screenH * 0.02),
          LoginTextField(
            controller: passwordController,
            label: l10n.password,
            hint: l10n.enterYourPassword,
            obscureText: true,
            validator: passwordValidator,
          ),
          SizedBox(height: screenH * 0.015),
          _RememberMeRow(
            rememberMe: rememberMe,
            onChanged: onRememberMeChanged,
          ),
        ],
      ),
    );
  }
}

class _RememberMeRow extends StatelessWidget {
  final bool rememberMe;
  final ValueChanged<bool?> onChanged;

  const _RememberMeRow({required this.rememberMe, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Checkbox(
                value: rememberMe,
                onChanged: onChanged,
                activeColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Flexible(
                child: Text(
                  l10n.rememberMe,
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => context.push(RoutePath.forgetPassword),
          child: Text(
            l10n.forgetPassword,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.primary,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
