import 'package:florista_ecommerce_app/core/router/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';

import '../../config/di/di.dart';
import '../../features/auth/login/presentation/screen/login_screen.dart';
import '../../features/auth/login/presentation/screen/login_screen.dart';
import '../../features/auth/login/presentation/view/login_screen.dart';
import '../../features/splash_screen/splash_screen.dart';

abstract class AppRouter {
  static final GoRouter goRouter = GoRouter(
    initialLocation: RoutePath.splash,
    //TODO: Add the actual screens instead of Placeholder() widgets
    routes: [
      GoRoute(
        path: RoutePath.splash,
        builder: (context, state) => const SplashScreen(),
      ),

      GoRoute(
        path: RoutePath.login,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<LoginCubit>(),
          child: const LoginScreen(),
        ),
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
