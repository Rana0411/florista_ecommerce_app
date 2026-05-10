import 'package:florista_ecommerce_app/core/router/route_path.dart';
import 'package:florista_ecommerce_app/features/auth/forget_password/presentation/screens/forget_password_view.dart';
import 'package:florista_ecommerce_app/features/auth/forget_password/presentation/screens/reset_password_view.dart';
import 'package:florista_ecommerce_app/features/auth/forget_password/presentation/screens/validation_code_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final _navigatorKey = GlobalKey<NavigatorState>();

  static GoRouter get router => _goRouter;

  static final GoRouter _goRouter = GoRouter(
    navigatorKey: _navigatorKey,
    initialLocation: RoutePath.validationCode,
    //TODO: Add the actual screens instead of Placeholder() widgets
    routes: [
      GoRoute(
        path: RoutePath.splash,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        path: RoutePath.login,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        path: RoutePath.signup,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        path: RoutePath.forgetPassword,
        builder: (context, state) => const ForgetPasswordView(),
      ),
      GoRoute(
        path: RoutePath.resetPassword,
        builder: (context, state) => const ResetPasswordView(),
      ),
      GoRoute(
        path: RoutePath.validationCode,
        builder: (context, state) => const ValidationCodeView(),
      ),
      //TODO: Use StatefulShellRoute for the home screen and its nested routes
    ],
  );
}
