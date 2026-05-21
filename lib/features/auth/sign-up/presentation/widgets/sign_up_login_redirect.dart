import 'package:florista_ecommerce_app/core/router/route_path.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../generated/l10n.dart';

class SignUpLoginRedirect extends StatelessWidget {
  const SignUpLoginRedirect({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: RichText(
        text: TextSpan(
          style: textTheme.titleMedium,
          children: [
            TextSpan(text: S.of(context).alreadyHaveAnAccount),
            TextSpan(
              text: S.of(context).login,
              style: textTheme.titleMedium?.copyWith(
                color: AppColors.primary,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w600,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => context.go(RoutePath.login),
            ),
          ],
        ),
      ),
    );
  }
}
