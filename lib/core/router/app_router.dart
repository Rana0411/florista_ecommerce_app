import 'package:florista_ecommerce_app/core/router/route_path.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final _navigatorKey = GlobalKey<NavigatorState>();

  static GoRouter get router => _goRouter;

  static final GoRouter _goRouter = GoRouter(
    navigatorKey: _navigatorKey,
    initialLocation: RoutePath.splash,
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
        builder: (context, state) => const Placeholder(),
      ),
      //TODO: Use StatefulShellRoute for the home screen and its nested routes
    ],
  );
}
