import 'package:flutter/material.dart';

import '../../../../../../config/text_field_validator.dart';
import '../../../../../../generated/l10n.dart';
import 'sign_up_text_field.dart';

class SignUpNameRow extends StatelessWidget {
  const SignUpNameRow({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
  });

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SignUpTextField(
            controller: firstNameController,
            label: S.of(context).firstName,
            hint: S.of(context).enterFirstName,
            validator: AppTextFieldValidator.validateName,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: SignUpTextField(
            controller: lastNameController,
            label: S.of(context).lastName,
            hint: S.of(context).enterLastName,
            validator: AppTextFieldValidator.validateName,
          ),
        ),
      ],
    );
  }
}
