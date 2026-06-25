import 'dart:math' as math;

import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

/// An animated, dependency-free illustration of the delivery vehicle.
///
/// The original design uses a custom illustration asset; since no such
/// asset ships with this project, the car is drawn with [CustomPaint].
/// To convey "the driver is on the way", the car:
/// - bobs gently up and down (suspension bounce),
/// - rotates its wheels continuously,
/// - drives over a scrolling dashed road line that loops endlessly,
///   giving the illusion of constant forward motion.
class DeliveryVehicleCard extends StatefulWidget {
  const DeliveryVehicleCard({super.key});

  @override
  State<DeliveryVehicleCard> createState() => _DeliveryVehicleCardState();
}

class _DeliveryVehicleCardState extends State<DeliveryVehicleCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      width: double.infinity,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final t = _controller.value; // 0.0 -> 1.0, looping
          // Gentle up/down bob using a sine wave (two bounces per loop).
          final bounce = math.sin(t * 4 * math.pi) * 3;

          return Center(
            child: SizedBox(
              width: 260,
              height: 130,
              child: CustomPaint(
                painter: _CarScenePainter(
                  color: AppColors.primary,
                  wheelRotation: t * 2 * math.pi,
                  roadOffset: t,
                  bodyBounce: bounce,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CarScenePainter extends CustomPainter {
  final Color color;
  final double wheelRotation;
  final double roadOffset;
  final double bodyBounce;

  _CarScenePainter({
    required this.color,
    required this.wheelRotation,
    required this.roadOffset,
    required this.bodyBounce,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    _drawRoad(canvas, w, h);

    canvas.save();
    canvas.translate(0, bodyBounce);
    _drawCar(canvas, w, h);
    canvas.restore();
  }

  void _drawRoad(Canvas canvas, double w, double h) {
    final roadPaint = Paint()
      ..color = AppColors.hintColor.withOpacity(0.25)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final roadY = h * 0.92;
    canvas.drawLine(Offset(0, roadY), Offset(w, roadY), roadPaint);

    // Scrolling dashes to simulate forward motion.
    final dashPaint = Paint()
      ..color = AppColors.hintColor.withOpacity(0.45)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    const dashWidth = 14.0;
    const gapWidth = 12.0;
    final cycle = dashWidth + gapWidth;
    final shift = roadOffset * cycle;

    var x = -cycle + (shift % cycle);
    while (x < w) {
      canvas.drawLine(
        Offset(x, roadY),
        Offset(x + dashWidth, roadY),
        dashPaint,
      );
      x += cycle;
    }
  }

  void _drawCar(Canvas canvas, double w, double h) {
    final bodyPaint = Paint()..color = color;
    final glassPaint = Paint()..color = Colors.white.withOpacity(0.85);
    final wheelPaint = Paint()..color = const Color(0xff2B2B2B);
    final wheelHubPaint = Paint()..color = const Color(0xff5A5A5A);

    // Car body (lower wide section).
    final bodyRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, h * 0.45, w, h * 0.40),
      const Radius.circular(18),
    );
    canvas.drawRRect(bodyRect, bodyPaint);

    // Car cabin (upper section).
    final cabinPath = Path()
      ..moveTo(w * 0.16, h * 0.50)
      ..quadraticBezierTo(w * 0.20, h * 0.12, w * 0.40, h * 0.10)
      ..lineTo(w * 0.66, h * 0.10)
      ..quadraticBezierTo(w * 0.82, h * 0.12, w * 0.86, h * 0.50)
      ..close();
    canvas.drawPath(cabinPath, bodyPaint);

    // Windows.
    final windowPath = Path()
      ..moveTo(w * 0.24, h * 0.48)
      ..quadraticBezierTo(w * 0.27, h * 0.20, w * 0.41, h * 0.18)
      ..lineTo(w * 0.50, h * 0.18)
      ..lineTo(w * 0.50, h * 0.48)
      ..close();
    canvas.drawPath(windowPath, glassPaint);

    final windowPath2 = Path()
      ..moveTo(w * 0.52, h * 0.18)
      ..lineTo(w * 0.64, h * 0.18)
      ..quadraticBezierTo(w * 0.76, h * 0.20, w * 0.79, h * 0.48)
      ..lineTo(w * 0.52, h * 0.48)
      ..close();
    canvas.drawPath(windowPath2, glassPaint);

    // Headlight + taillight accents.
    final lightPaint = Paint()..color = Colors.white.withOpacity(0.9);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.02, h * 0.58, w * 0.06, h * 0.08),
        const Radius.circular(4),
      ),
      lightPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.92, h * 0.58, w * 0.06, h * 0.08),
        const Radius.circular(4),
      ),
      lightPaint,
    );

    // Wheels (rotating).
    _drawWheel(
      canvas,
      Offset(w * 0.26, h * 0.86),
      h * 0.16,
      wheelPaint,
      wheelHubPaint,
      wheelRotation,
    );
    _drawWheel(
      canvas,
      Offset(w * 0.74, h * 0.86),
      h * 0.16,
      wheelPaint,
      wheelHubPaint,
      wheelRotation,
    );
  }

  void _drawWheel(
    Canvas canvas,
    Offset center,
    double radius,
    Paint tyrePaint,
    Paint hubPaint,
    double rotation,
  ) {
    canvas.drawCircle(center, radius, tyrePaint);
    canvas.drawCircle(center, radius * 0.45, hubPaint);

    // Spokes rotate with the wheel to sell the motion.
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    final spokePaint = Paint()
      ..color = const Color(0xff8A8A8A)
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;
    for (var i = 0; i < 3; i++) {
      final angle = (i * math.pi) / 3;
      final dx = math.cos(angle) * radius * 0.45;
      final dy = math.sin(angle) * radius * 0.45;
      canvas.drawLine(Offset(-dx, -dy), Offset(dx, dy), spokePaint);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _CarScenePainter oldDelegate) =>
      oldDelegate.wheelRotation != wheelRotation ||
      oldDelegate.roadOffset != roadOffset ||
      oldDelegate.bodyBounce != bodyBounce ||
      oldDelegate.color != color;
}
