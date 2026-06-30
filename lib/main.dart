import 'package:florista_ecommerce_app/config/di/di.dart';
import 'package:florista_ecommerce_app/config/hive/hive_service.dart';
import 'package:florista_ecommerce_app/config/secure_storage/secure_storage_service.dart';
import 'package:florista_ecommerce_app/core/app_keys/secure_storage_keys.dart';
import 'package:florista_ecommerce_app/core/router/app_router.dart';
import 'package:florista_ecommerce_app/core/utils/themes/dark_theme.dart';
import 'package:florista_ecommerce_app/core/utils/themes/light_theme.dart';
import 'package:florista_ecommerce_app/features/cart/presentation/view_model/cart_cubit.dart';
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
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNmEwZmM3YzFhMWUyOThmNTU2MjM5OGE4Iiwicm9sZSI6InVzZXIiLCJpYXQiOjE3Nzk0MTkwOTF9.VrT41fzyf9CTR1GE20iWcvJ5oif3pj2yjZnkzPUQ6K8',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider.value(value: getIt.get<CartCubit>())],
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
