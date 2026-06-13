import 'package:florista_ecommerce_app/config/di/di.dart';
import 'package:florista_ecommerce_app/config/hive/hive_service.dart';
import 'package:florista_ecommerce_app/config/secure_storage/secure_storage_service.dart';
import 'package:florista_ecommerce_app/core/app_keys/secure_storage_keys.dart';
import 'package:florista_ecommerce_app/core/router/app_router.dart';
import 'package:florista_ecommerce_app/core/utils/themes/dark_theme.dart';
import 'package:florista_ecommerce_app/core/utils/themes/light_theme.dart';
import 'package:florista_ecommerce_app/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:florista_ecommerce_app/features/payment/presentation/view_model/payment_cubit.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  final hive = getIt<HiveService>();
  await hive.init();

  SecureStorageService secureStorage = getIt<SecureStorageService>();
  await secureStorage.write(
    key: SecureStorageKeys.token,
    value:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjllMmJmNDg2YmJhZjE1ODhiYmM5MzcyIiwicm9sZSI6InVzZXIiLCJpYXQiOjE3ODEzNTgyNjN9.N0w2E9mBneZ4dS2i7ZcNgfcFQSk8t28fPbClxtY1ljU",
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<PaymentCubit>()),
        BlocProvider(create: (_) => getIt<CartCubit>()),
      ],
      child: MaterialApp.router(
        title: 'Florista Shop App',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [S.delegate],
        supportedLocales: S.delegate.supportedLocales,
        routerConfig: AppRouter.goRouter,
        theme: TLightTheme.lightTheme,
        darkTheme: TDarkTheme.darkTheme,
        themeMode: ThemeMode.system,
      ),
    );
  }
}
