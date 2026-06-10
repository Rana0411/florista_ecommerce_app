import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:florista_ecommerce_app/config/di/di.dart';
import 'package:florista_ecommerce_app/config/hive/hive_service.dart';
import 'package:florista_ecommerce_app/config/notification/firebase_notification_service.dart';
import 'package:florista_ecommerce_app/core/router/app_router.dart';
import 'package:florista_ecommerce_app/core/utils/themes/dark_theme.dart';
import 'package:florista_ecommerce_app/core/utils/themes/light_theme.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  // 1. Hive local storage
  final hive = getIt<HiveService>();
  await hive.init();

  // 2. Initialize Firebase
  await Firebase.initializeApp();

  // 3. Pass all uncaught asynchronous errors from the framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  // 4. Pass all uncaught Flutter framework errors to Crashlytics
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  // 5. Start Firebase notification service (FCM setup)
  await getIt<FirebaseNotificationService>().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Florista Shop App',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [S.delegate],
      supportedLocales: S.delegate.supportedLocales,
      routerConfig: AppRouter.goRouter,
      theme: TLightTheme.lightTheme,
      darkTheme: TDarkTheme.darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}
