import 'package:florista_ecommerce_app/core/router/route_path.dart';
import 'package:florista_ecommerce_app/features/Cart/presentation/view/cart_view.dart';
import 'package:florista_ecommerce_app/features/auth/forget_password/presentation/view/forget_password_view.dart';
import 'package:florista_ecommerce_app/features/auth/forget_password/presentation/view/otp_verification_view.dart';
import 'package:florista_ecommerce_app/features/auth/forget_password/presentation/view/reset_password_view.dart';
import 'package:florista_ecommerce_app/features/auth/login/presentation/view/login_view.dart';
import 'package:florista_ecommerce_app/features/categories/presentation/view/categories_view.dart';
import 'package:florista_ecommerce_app/features/home/presentation/view/home_view.dart';
import 'package:florista_ecommerce_app/features/profile/presentation/view/profile_view.dart';
import 'package:florista_ecommerce_app/features/splash/presentation/view/splash_view.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/sign-up/presentation/screens/sign_up_screen.dart';

abstract class AppRouter {
  static final GoRouter goRouter = GoRouter(
    initialLocation: RoutePath.signup,
    routes: [
      GoRoute(
        path: RoutePath.splash,
        builder: (context, state) => SplashView(),
      ),
      GoRoute(path: RoutePath.login, builder: (context, state) => LoginView()),
      GoRoute(
        path: RoutePath.signup,
        builder: (context, state) => SignUpScreen(),
      ),
      GoRoute(
        path: RoutePath.forgetPassword,
        builder: (context, state) => ForgetPasswordView(),
      ),
      GoRoute(
        path: RoutePath.otpVerification,
        builder: (context, state) => OtpVerificationView(),
      ),
      GoRoute(
        path: RoutePath.resetPassword,
        builder: (context, state) => ResetPasswordView(),
      ),
      GoRoute(path: RoutePath.home, builder: (context, state) => HomeView()),
      GoRoute(
        path: RoutePath.categories,
        builder: (context, state) => CategoriesView(),
      ),
      GoRoute(path: RoutePath.cart, builder: (context, state) => CartView()),
      GoRoute(
        path: RoutePath.profile,
        builder: (context, state) => ProfileView(),
      ),
    ],
  );
}
