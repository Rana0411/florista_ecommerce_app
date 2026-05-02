import 'dart:io';

import 'package:florista_ecommerce_app/config/di/di.dart';
import 'package:florista_ecommerce_app/config/hive/hive_service.dart';
import 'package:florista_ecommerce_app/core/router/app_router.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  final dir = getIt<Directory>();
  await HiveService.init(dir);

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
      routeInformationParser: getIt.get(),
      routerDelegate: getIt.get(),
      supportedLocales: S.delegate.supportedLocales,
      routerConfig: AppRouter.router,
    );
  }
}
