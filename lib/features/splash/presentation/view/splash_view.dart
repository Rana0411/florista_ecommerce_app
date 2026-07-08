import 'dart:ui';

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
/// Plays a branded intro (ambient bloom backdrop fade-in, logo entrance
/// with a soft elevated card + gentle post-entrance "breathing" pulse,
/// gradient brand text, and a pulsing-dot loader) and then navigates on
/// to [RoutePath.login]. Navigation is guarded so it can never fire twice
/// and never fires after the widget has been disposed.
///
/// Note: the login screen itself is responsible for pre-filling the
/// email/password fields and the "remember me" checkbox from secure
/// storage — splash always routes to login, it does not skip it.
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with TickerProviderStateMixin {
  static const _splashDuration = Duration(milliseconds: 1900);
  static const _holdDuration = Duration(milliseconds: 1300);

  /// One-shot entrance animation: backdrop, logo, text, loader.
  late final AnimationController _entrance;

  /// Continuous, subtle "breathing" loop that starts once the entrance
  /// settles — gives the logo and loader a bit of life without being
  /// distracting.
  late final AnimationController _pulse;

  late final Animation<double> _backdropOpacity;
  late final Animation<double> _logoScale;
  late final Animation<double> _logoOpacity;
  late final Animation<double> _cardShadow;
  late final Animation<double> _textOpacity;
  late final Animation<Offset> _textSlide;
  late final Animation<double> _loaderOpacity;

  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();

    _entrance = AnimationController(vsync: this, duration: _splashDuration);
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1700),
    );

    _backdropOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entrance,
        curve: const Interval(0.0, 0.45, curve: Curves.easeOut),
      ),
    );

    _logoScale = Tween<double>(begin: 0.55, end: 1.0).animate(
      CurvedAnimation(
        parent: _entrance,
        curve: const Interval(0.05, 0.65, curve: Curves.easeOutBack),
      ),
    );

    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entrance,
        curve: const Interval(0.05, 0.5, curve: Curves.easeIn),
      ),
    );

    _cardShadow = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entrance,
        curve: const Interval(0.2, 0.7, curve: Curves.easeOut),
      ),
    );

    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entrance,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.35),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _entrance,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    _loaderOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entrance,
        curve: const Interval(0.78, 1.0, curve: Curves.easeIn),
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

    _entrance.addStatusListener((status) {
      // Once the one-shot entrance settles, start the gentle ambient loop.
      if (status == AnimationStatus.completed && mounted) {
        _pulse.repeat(reverse: true);
      }
    });

    _entrance.forward();
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
    _entrance.dispose();
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isSmall = constraints.maxWidth < 360;
        final bool isLarge = constraints.maxWidth > 600;

        final double logoSize = isLarge
            ? ScreenSize.w(context, 0.26)
            : isSmall
            ? ScreenSize.w(context, 0.34)
            : ScreenSize.w(context, 0.30);

        final double cardSize = logoSize * 1.65;

        return Scaffold(
          backgroundColor: AppColors.white,
          body: GestureDetector(
            // Let an impatient user skip straight through, without
            // breaking the "only navigate once" guarantee.
            onTap: _goToLogin,
            behavior: HitTestBehavior.opaque,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Soft vertical wash so the white background reads as
                // premium rather than flat/empty.
                FadeTransition(
                  opacity: _backdropOpacity,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.white,
                          AppColors.primary.withOpacity(0.06),
                          AppColors.white,
                        ],
                        stops: const [0.0, 0.55, 1.0],
                      ),
                    ),
                  ),
                ),

                // Ambient bloom shapes — soft, blurred, out of the way of
                // the logo/text so they read as atmosphere, not clutter.
                _BloomBlob(
                  opacity: _backdropOpacity,
                  alignment: const Alignment(-1.25, -1.05),
                  diameter: ScreenSize.w(context, 0.85),
                  color: AppColors.primary.withOpacity(0.16),
                ),
                _BloomBlob(
                  opacity: _backdropOpacity,
                  alignment: const Alignment(1.3, 1.1),
                  diameter: ScreenSize.w(context, 0.95),
                  color: AppColors.primary.withOpacity(0.12),
                ),

                SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(flex: 3),
                      _LogoCard(
                        entrance: _entrance,
                        pulse: _pulse,
                        scale: _logoScale,
                        opacity: _logoOpacity,
                        shadowStrength: _cardShadow,
                        cardSize: cardSize,
                        logoSize: logoSize,
                      ),
                      SizedBox(height: ScreenSize.h(context, 0.045)),
                      _BrandText(
                        opacity: _textOpacity,
                        slide: _textSlide,
                        isLarge: isLarge,
                        isSmall: isSmall,
                      ),
                      const Spacer(flex: 3),
                      _DotsLoader(
                        opacity: _loaderOpacity,
                        pulse: _pulse,
                        dotSize: ScreenSize.w(context, 0.022),
                      ),
                      SizedBox(height: ScreenSize.h(context, 0.06)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Large, softly blurred circle used to give the backdrop depth without
/// competing with the logo for attention.
class _BloomBlob extends StatelessWidget {
  const _BloomBlob({
    required this.opacity,
    required this.alignment,
    required this.diameter,
    required this.color,
  });

  final Animation<double> opacity;
  final Alignment alignment;
  final double diameter;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: FadeTransition(
        opacity: opacity,
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
          child: Container(
            width: diameter,
            height: diameter,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
        ),
      ),
    );
  }
}

/// Logo presented on an elevated rounded card, with an entrance
/// scale/fade and a gentle continuous "breathing" scale once settled.
class _LogoCard extends StatelessWidget {
  const _LogoCard({
    required this.entrance,
    required this.pulse,
    required this.scale,
    required this.opacity,
    required this.shadowStrength,
    required this.cardSize,
    required this.logoSize,
  });

  final AnimationController entrance;
  final AnimationController pulse;
  final Animation<double> scale;
  final Animation<double> opacity;
  final Animation<double> shadowStrength;
  final double cardSize;
  final double logoSize;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([entrance, pulse]),
      builder: (context, child) {
        // Subtle breathing scale (1.0 -> 1.03) layered on top of the
        // one-shot entrance scale, active only once entrance has settled.
        final breathing = entrance.isCompleted
            ? 1.0 + (pulse.value * 0.03)
            : 1.0;

        return Opacity(
          opacity: opacity.value,
          child: Transform.scale(
            scale: scale.value * breathing,
            child: child,
          ),
        );
      },
      child: Container(
        width: cardSize,
        height: cardSize,
        padding: EdgeInsets.all(cardSize * 0.16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(cardSize * 0.28),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.white, AppColors.primary.withOpacity(0.05)],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.22),
              blurRadius: 32,
              spreadRadius: -4,
              offset: const Offset(0, 16),
            ),
            BoxShadow(
              color: AppColors.primary.withOpacity(0.10),
              blurRadius: 60,
              spreadRadius: 4,
              offset: const Offset(0, 28),
            ),
          ],
        ),
        child: Semantics(
          label: 'Florista logo',
          image: true,
          child: Image.asset(
            AssetsManager.logo,
            width: logoSize,
            height: logoSize,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => Icon(
              Icons.local_florist_rounded,
              size: logoSize,
              color: AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}

/// Animated app name + tagline block. The brand name uses a subtle
/// gradient fill for a more premium, less flat look than a solid color.
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
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary,
                  Color.lerp(AppColors.primary, Colors.black, 0.25)!,
                ],
              ).createShader(bounds),
              child: Text(
                'Florista',
                style: TextStyle(
                  fontFamily: AppFonts.interFamily,
                  fontSize: isLarge ? FontSize.s28 * 1.5 : FontSize.s28 * 1.1,
                  fontWeight: FontWeightManager.bold,
                  color: Colors.white,
                  letterSpacing: 2.0,
                ),
              ),
            ),
            SizedBox(height: ScreenSize.h(context, 0.01)),
            Text(
              S.of(context).splashTagline,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppFonts.interFamily,
                fontSize: isSmall ? FontSize.s12 : FontSize.s14,
                fontWeight: FontWeightManager.light,
                color: AppColors.grey,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Three-dot pulsing loader — a calmer, more polished alternative to a
/// spinning circular indicator, in step with the ambient [pulse] loop.
class _DotsLoader extends StatelessWidget {
  const _DotsLoader({
    required this.opacity,
    required this.pulse,
    required this.dotSize,
  });

  final Animation<double> opacity;
  final AnimationController pulse;
  final double dotSize;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacity,
      child: AnimatedBuilder(
        animation: pulse,
        builder: (context, _) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(3, (index) {
              // Stagger each dot's phase so they pulse in a gentle wave
              // rather than all together.
              final t = (pulse.value + (index * 0.25)) % 1.0;
              final wave = (t < 0.5) ? t / 0.5 : (1.0 - t) / 0.5;
              final scale = 0.6 + (wave * 0.6);
              final dotOpacity = 0.35 + (wave * 0.65);

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: dotSize * 0.45),
                child: Opacity(
                  opacity: dotOpacity,
                  child: Transform.scale(
                    scale: scale,
                    child: Container(
                      width: dotSize,
                      height: dotSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
