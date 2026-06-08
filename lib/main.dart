import 'package:device_preview/device_preview.dart';
import 'package:florista_ecommerce_app/config/di/di.dart';
import 'package:florista_ecommerce_app/config/hive/hive_service.dart';
import 'package:florista_ecommerce_app/config/secure_storage/secure_storage_service.dart';
import 'package:florista_ecommerce_app/core/app_keys/secure_storage_keys.dart';
import 'package:florista_ecommerce_app/core/router/app_router.dart';
import 'package:florista_ecommerce_app/core/utils/themes/dark_theme.dart';
import 'package:florista_ecommerce_app/core/utils/themes/light_theme.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  final hive = getIt<HiveService>();
  await hive.init();

  SecureStorageService secureStorage = getIt<SecureStorageService>();
  await secureStorage.write(
    key: SecureStorageKeys.token,
    value:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjllMmJmNDg2YmJhZjE1ODhiYmM5MzcyIiwicm9sZSI6InVzZXIiLCJpYXQiOjE3ODA4ODYyMjZ9.KhR4PqLG1nbXa1083Ojlom3ubYgir3aB4YN0vgsf4lc',
  );

  runApp(
    DevicePreview(enabled: !kReleaseMode, builder: (context) => const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Florista Shop App',
      debugShowCheckedModeBanner: false,

      // 👇 مهمين عشان DevicePreview يشتغل مع router
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,

      localizationsDelegates: [S.delegate],
      supportedLocales: S.delegate.supportedLocales,
      routerConfig: AppRouter.goRouter,
      theme: TLightTheme.lightTheme,
      darkTheme: TDarkTheme.darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}
