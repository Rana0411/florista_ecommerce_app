import 'package:florista_ecommerce_app/config/di/di.dart';
import 'package:florista_ecommerce_app/config/hive/hive_service.dart';
import 'package:florista_ecommerce_app/core/router/app_router.dart';
import 'package:florista_ecommerce_app/core/utils/themes/dark_theme.dart';
import 'package:florista_ecommerce_app/core/utils/themes/light_theme.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final hive = getIt<HiveService>();
  await hive.init();
  await configureDependencies();

  runApp(const MyApp());
}

@Preview()
Widget returnWidgetPreview() => MyApp();

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
