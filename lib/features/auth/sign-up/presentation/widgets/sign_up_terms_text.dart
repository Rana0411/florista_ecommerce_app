import 'package:flutter/material.dart';

import '../../../../../../generated/l10n.dart';

class SignUpTermsText extends StatelessWidget {
  const SignUpTermsText({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return RichText(
      text: TextSpan(
        style: textTheme.bodyMedium?.copyWith(fontSize: 13),
        children: [
          TextSpan(text: S.of(context).creatingAnAccountYouAgreeToOur),
          TextSpan(
            text: S.of(context).termsConditions,
            style: textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}
