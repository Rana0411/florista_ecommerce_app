import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../core/shared_widgets/web_view_screen.dart';

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
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const WebViewScreen(
                      url: 'https://elevate-flutter-team.github.io/flower_app_web_views/terms.html',
                      title: 'Terms & Conditions',
                    ),
                  ),
                );
              },
          ),
        ],
      ),
    );
  }
}