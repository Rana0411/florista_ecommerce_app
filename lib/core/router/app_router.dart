import 'package:florista_ecommerce_app/config/di/di.dart';
import 'package:florista_ecommerce_app/config/shared_models/user_data/user_request_dto.dart';
import 'package:florista_ecommerce_app/core/router/route_path.dart';
import 'package:florista_ecommerce_app/features/Cart/presentation/view/cart_view.dart';
import 'package:florista_ecommerce_app/features/auth/forget_password/presentation/screens/forget_password_view.dart';
import 'package:florista_ecommerce_app/features/auth/forget_password/presentation/screens/reset_password_view.dart';
import 'package:florista_ecommerce_app/features/auth/forget_password/presentation/screens/validation_code_view.dart';
import 'package:florista_ecommerce_app/features/auth/login/presentation/view/login_view.dart';
import 'package:florista_ecommerce_app/features/auth/sign-up/presentation/screens/sign_up_screen.dart';
import 'package:florista_ecommerce_app/features/categories/domain/use_cases/categories_use_cases.dart';
import 'package:florista_ecommerce_app/features/categories/presentation/view/categories_view.dart';
import 'package:florista_ecommerce_app/features/change_password/presentation/view/change_password_view.dart';
import 'package:florista_ecommerce_app/features/change_password/presentation/view_model/cubit/change_password_view_model.dart';
import 'package:florista_ecommerce_app/features/edit_profile/presentation/view/edit_profile_view.dart';
import 'package:florista_ecommerce_app/features/edit_profile/presentation/view_model/cubit/edit_profile_view_model.dart';
import 'package:florista_ecommerce_app/features/home/presentation/view/home_view.dart';
import 'package:florista_ecommerce_app/features/home/presentation/view_model/home_event.dart';
import 'package:florista_ecommerce_app/features/home/presentation/view_model/home_view_model.dart';
import 'package:florista_ecommerce_app/features/profile/presentation/view/profile_view.dart';
import 'package:florista_ecommerce_app/features/profile/presentation/view_model/profile_events.dart';
import 'package:florista_ecommerce_app/features/profile/presentation/view_model/profile_view_model.dart';
import 'package:florista_ecommerce_app/features/splash/presentation/view/splash_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/best_seller/presentation/screens/best_seller_view.dart';
import '../../features/categories/domain/use_cases/get_products_by_category_use_case.dart';
import '../../features/categories/presentation/cubit/categories_view_model.dart';

abstract class AppRouter {
  static final GoRouter goRouter = GoRouter(
    initialLocation: RoutePath.profile,
    routes: [
      GoRoute(
        path: RoutePath.splash,
        builder: (context, state) => SplashView(),
      ),
      GoRoute(
        path: RoutePath.login,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: RoutePath.signup,
        builder: (context, state) => SignUpScreen(),
      ),
      GoRoute(
        path: RoutePath.forgetPassword,
        builder: (context, state) => ForgetPasswordView(),
      ),
      GoRoute(
        path: RoutePath.home,
        builder: (context, state) {
          final HomeViewModel viewModel = getIt.get<HomeViewModel>();
          return BlocProvider(
            create: (context) => viewModel..doEvent(HomeInitEvent()),
            child: HomeView(),
          );
        },
      ),
      GoRoute(
        path: RoutePath.categories,
        builder: (context, state) => BlocProvider(
          create: (_) => CategoriesCubit(
            getCategoriesUseCase: getIt<GetCategoriesUseCase>(),
            getProductsByCategoryUseCase: getIt<GetProductsByCategoryUseCase>(),
          ),
          child: const CategoriesView(),
        ),
      ),
      GoRoute(path: RoutePath.cart, builder: (context, state) => CartView()),
      GoRoute(
        path: RoutePath.bestSeller,
        builder: (context, state) => BestSellerView(),
      ),
      GoRoute(
        path: RoutePath.resetPassword,
        builder: (context, state) => const ResetPasswordView(),
      ),
      GoRoute(
        path: RoutePath.validationCode,
        builder: (context, state) => const ValidationCodeView(),
      ),
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
        builder: (context, state) {
          final viewModle = getIt.get<EditProfileViewModel>();
          return BlocProvider(
            create: (context) => viewModle,
            child: EditProfileView(user: state.extra as UserRequestDto),
          );
        },
      ),
      GoRoute(
        path: RoutePath.changePassword,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => getIt.get<ChangePasswordViewModel>(),
            child: ChangePasswordView(),
          );
        },
      ),
    ],
  );
}
