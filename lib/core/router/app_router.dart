import 'package:florista_ecommerce_app/config/di/di.dart';
import 'package:florista_ecommerce_app/config/shared_models/user_data/user_request_dto.dart';
import 'package:florista_ecommerce_app/core/router/route_path.dart';
import 'package:florista_ecommerce_app/features/Cart/presentation/view/cart_view.dart';
import 'package:florista_ecommerce_app/features/auth/forget_password/presentation/view/forget_password_view.dart';
import 'package:florista_ecommerce_app/features/auth/forget_password/presentation/view/otp_verification_view.dart';
import 'package:florista_ecommerce_app/features/auth/forget_password/presentation/view/reset_password_view.dart';
import 'package:florista_ecommerce_app/features/auth/login/presentation/view/login_view.dart';
import 'package:florista_ecommerce_app/features/auth/sign_up/presentation/view/sign_up_view.dart';
import 'package:florista_ecommerce_app/features/categories/presentation/view/categories_view.dart';
import 'package:florista_ecommerce_app/features/edit_profile/presentation/view/edit_profile_view.dart';
import 'package:florista_ecommerce_app/features/home/presentation/view/home_view.dart';
import 'package:florista_ecommerce_app/features/profile/presentation/view/profile_view.dart';
import 'package:florista_ecommerce_app/features/profile/presentation/view_model/profile_events.dart';
import 'package:florista_ecommerce_app/features/profile/presentation/view_model/profile_view_model.dart';
import 'package:florista_ecommerce_app/features/splash/presentation/view/splash_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static final GoRouter goRouter = GoRouter(
    initialLocation: RoutePath.splash,
    routes: [
      GoRoute(
        path: RoutePath.splash,
        builder: (context, state) => SplashView(),
      ),
      GoRoute(path: RoutePath.login, builder: (context, state) => LoginView()),
      GoRoute(
        path: RoutePath.signup,
        builder: (context, state) => SignUpView(),
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
        builder: (context, state) => BlocProvider(
          create: (context) =>
              getIt.get<ProfileViewModel>()..doEvent(GetUserDataEvent()),
          child: ProfileView(),
        ),
      ),
      GoRoute(
        path: RoutePath.editProfile,
        builder: (context, state) =>
            EditProfileView(user: state.extra as UserRequestDto),
      ),
    ],
  );
}
