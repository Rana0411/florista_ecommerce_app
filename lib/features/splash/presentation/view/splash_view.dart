import 'package:florista_ecommerce_app/core/router/route_path.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/assets_manager.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/core/utils/responsive/screen_size.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

/// Splash screen shown on app launch.
///
/// Plays a short branded intro animation (logo scale/fade + text slide-in)
/// and then navigates on to [RoutePath.login]. Navigation is guarded so it
/// can never fire twice and never fires after the widget has been disposed.
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  static const _splashDuration = Duration(milliseconds: 1800);
  static const _holdDuration = Duration(milliseconds: 1400);

  late final AnimationController _controller;
  late final Animation<double> _logoScale;
  late final Animation<double> _logoOpacity;
  late final Animation<double> _textOpacity;
  late final Animation<Offset> _textSlide;
  late final Animation<double> _loaderOpacity;

  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: _splashDuration,
    );

    _logoScale = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    _loaderOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.75, 1.0, curve: Curves.easeIn),
      ),
    );

    // Make the splash blend with the system chrome instead of leaving
    // default status/nav bar colors behind.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: AppColors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      );
    });

    _controller.forward();
    _scheduleNavigation();
  }

  void _scheduleNavigation() {
    // Total time on screen = animation length + a short hold, so the brand
    // moment doesn't feel rushed on fast devices or clipped on slow ones.
    Future.delayed(_splashDuration + _holdDuration, _goToLogin);
  }

  void _goToLogin() {
    if (!mounted || _hasNavigated) return;
    _hasNavigated = true;
    context.go(RoutePath.login);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isSmall = constraints.maxWidth < 360;
        final bool isLarge = constraints.maxWidth > 600;

        final double logoSize = isLarge
            ? ScreenSize.w(context, 0.30)
            : isSmall
            ? ScreenSize.w(context, 0.50)
            : ScreenSize.w(context, 0.42);

        return Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: GestureDetector(
              // Let an impatient user skip straight through, without
              // breaking the "only navigate once" guarantee.
              onTap: _goToLogin,
              behavior: HitTestBehavior.opaque,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(flex: 3),
                  _Logo(
                    controller: _controller,
                    scale: _logoScale,
                    opacity: _logoOpacity,
                    size: logoSize,
                  ),
                  SizedBox(height: ScreenSize.h(context, 0.04)),
                  _BrandText(
                    opacity: _textOpacity,
                    slide: _textSlide,
                    isLarge: isLarge,
                    isSmall: isSmall,
                  ),
                  const Spacer(flex: 3),
                  _Loader(opacity: _loaderOpacity, size: ScreenSize.w(context, 0.08)),
                  SizedBox(height: ScreenSize.h(context, 0.06)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Animated logo with graceful fallback if the asset ever fails to load.
class _Logo extends StatelessWidget {
  const _Logo({
    required this.controller,
    required this.scale,
    required this.opacity,
    required this.size,
  });

  final AnimationController controller;
  final Animation<double> scale;
  final Animation<double> opacity;
  final double size;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Opacity(
          opacity: opacity.value,
          child: Transform.scale(scale: scale.value, child: child),
        );
      },
      child: Semantics(
        label: 'Florista logo',
        image: true,
        child: Image.asset(
          AssetsManager.logo,
          width: size,
          height: size,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => Icon(
            Icons.local_florist_rounded,
            size: size,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}

/// Animated app name + tagline block.
class _BrandText extends StatelessWidget {
  const _BrandText({
    required this.opacity,
    required this.slide,
    required this.isLarge,
    required this.isSmall,
  });

  final Animation<double> opacity;
  final Animation<Offset> slide;
  final bool isLarge;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacity,
      child: SlideTransition(
        position: slide,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Florista',
              style: TextStyle(
                fontFamily: AppFonts.interFamily,
                fontSize: isLarge ? FontSize.s28 * 1.4 : FontSize.s28,
                fontWeight: FontWeightManager.bold,
                color: AppColors.primary,
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(height: ScreenSize.h(context, 0.008)),
            Text(
              S.of(context).splashTagline,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppFonts.interFamily,
                fontSize: isSmall ? FontSize.s12 : FontSize.s14,
                fontWeight: FontWeightManager.light,
                color: AppColors.grey,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Fade-in loading indicator shown once the brand animation settles.
class _Loader extends StatelessWidget {
  const _Loader({required this.opacity, required this.size});

  final Animation<double> opacity;
  final double size;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacity,
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          backgroundColor: AppColors.primary.withOpacity(0.15),
          semanticsLabel: 'Loading',
        ),
      ),
    );
  }
}