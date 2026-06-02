import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../../../generated/l10n.dart';

class SignUpGenderRow extends StatelessWidget {
  const SignUpGenderRow({
    super.key,
    required this.gender,
    required this.onChanged,
  });

  final String gender;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Text(
          S.of(context).gender,
          style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(width: 40),
        _GenderOption(
          label: S.of(context).female,
          value: 'female',
          groupValue: gender,
          onChanged: onChanged,
        ),
        const SizedBox(width: 20),
        _GenderOption(
          label: S.of(context).male,
          value: 'male',
          groupValue: gender,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _GenderOption extends StatelessWidget {
  const _GenderOption({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  final String label;
  final String value;
  final String groupValue;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: value,
          groupValue: groupValue,
          activeColor: AppColors.primary,
          onChanged: (v) => onChanged(v!),
        ),
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
