import 'package:florista_ecommerce_app/core/router/route_path.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/assets_manager.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/core/utils/responsive/screen_size.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _textOpacity;
  late Animation<Offset> _textSlide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
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

    _textSlide = Tween<Offset>(begin: const Offset(0, 0.4), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
          ),
        );

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.go(RoutePath.login);
      }
    });
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
            ? ScreenSize.w(context, 0.35)
            : isSmall
            ? ScreenSize.w(context, 0.50)
            : ScreenSize.w(context, 0.42);

        return Scaffold(
          backgroundColor: AppColors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 3),

              // ── Logo: full image, no clipping ─────────────────────
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Opacity(
                    opacity: _logoOpacity.value,
                    child: Transform.scale(
                      scale: _logoScale.value,
                      child: child,
                    ),
                  );
                },
                child: Image.asset(
                  AssetsManager.logo,
                  width: logoSize,
                  height: logoSize,
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(height: ScreenSize.h(context, 0.04)),

              // ── App name + tagline ────────────────────────────────
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: _textOpacity,
                    child: SlideTransition(position: _textSlide, child: child),
                  );
                },
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

              const Spacer(flex: 3),

              // ── Loading indicator ─────────────────────────────────
              AnimatedBuilder(
                animation: _textOpacity,
                builder: (context, child) {
                  return Opacity(opacity: _textOpacity.value, child: child);
                },
                child: SizedBox(
                  width: ScreenSize.w(context, 0.08),
                  height: ScreenSize.w(context, 0.08),
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                    backgroundColor: AppColors.primary.withOpacity(0.15),
                  ),
                ),
              ),

              SizedBox(height: ScreenSize.h(context, 0.06)),
            ],
          ),
        );
      },
    );
  }
}
