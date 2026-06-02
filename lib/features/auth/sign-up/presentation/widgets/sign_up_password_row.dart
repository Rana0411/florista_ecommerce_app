import 'package:flutter/material.dart';

import '../../../../../../config/text_field_validator.dart';
import '../../../../../../generated/l10n.dart';
import 'sign_up_text_field.dart';

class SignUpPasswordRow extends StatelessWidget {
  const SignUpPasswordRow({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SignUpTextField(
            controller: passwordController,
            label: S.of(context).password,
            hint: S.of(context).enterPassword,
            isPassword: true,
            validator: AppTextFieldValidator.validatePassword,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: SignUpTextField(
            controller: confirmPasswordController,
            label: S.of(context).confirmPassword,
            hint: S.of(context).confirmPassword,
            isPassword: true,
            validator: (value) => AppTextFieldValidator.validateConfirmPassword(
              value,
              passwordController.text,
            ),
          ),
        ),
      ],
    );
  }
}
