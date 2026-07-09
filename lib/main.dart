import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:florista_ecommerce_app/config/di/di.dart';
import 'package:florista_ecommerce_app/config/hive/hive_service.dart';
import 'package:florista_ecommerce_app/config/secure_storage/secure_storage_service.dart';
import 'package:florista_ecommerce_app/core/router/app_router.dart';
import 'package:florista_ecommerce_app/core/utils/themes/dark_theme.dart';
import 'package:florista_ecommerce_app/core/utils/themes/light_theme.dart';
import 'package:florista_ecommerce_app/core/localization/florista_localization_delegate.dart';
import 'package:florista_ecommerce_app/features/app_language/locale_cubit.dart';
import 'package:florista_ecommerce_app/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:florista_ecommerce_app/firebase_options.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await configureDependencies();

  final hive = getIt<HiveService>();
  await hive.init();

  // NOTE: remove this block entirely once real auth/login flow is wired up.
  // Hardcoded tokens should never ship in source control.
  // If you still need a dev-only token for local testing, gate it behind
  // a debug flag, e.g. `if (kDebugMode) { ... }`, and load it from an
  // untracked .env file instead of committing it here.

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocaleCubit>(
          create: (context) => getIt<LocaleCubit>()..getSavedLanguage(),
        ),
        BlocProvider<CartCubit>(
          create: (context) => getIt<CartCubit>()..getCart(),
        ),
      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, state) {
          return MaterialApp.router(
            key: ValueKey(state.locale.languageCode),
            title: 'Florista Shop App',
            debugShowCheckedModeBanner: false,
            locale: state.locale,
            localeResolutionCallback: (locale, supportedLocales) {
              if (locale == null) {
                return const Locale('en');
              }
              for (final supported in supportedLocales) {
                if (supported.languageCode == locale.languageCode) {
                  return supported;
                }
              }
              return const Locale('en');
            },
            localizationsDelegates: const [
              FloristaLocalizationDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            routerConfig: AppRouter.goRouter,
            theme: TLightTheme.lightTheme,
            darkTheme: TDarkTheme.darkTheme,
            themeMode: ThemeMode.system,
          );
        },
      ),
    );
  }
}