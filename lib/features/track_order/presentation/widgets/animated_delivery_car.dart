import 'package:flutter/material.dart';

import 'package:florista_ecommerce_app/core/utils/app_colors.dart';


class AnimatedDeliveryCar extends StatefulWidget {
  const AnimatedDeliveryCar({super.key});

  @override
  State<AnimatedDeliveryCar> createState() => _AnimatedDeliveryCarState();
}

class _AnimatedDeliveryCarState extends State<AnimatedDeliveryCar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          // How far the car can travel left/right from the centre.
          final travel = (maxWidth - 140) / 2;

          return AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              final t = Curves.easeInOut.transform(_controller.value);
              final dx = (t * 2 - 1) * travel; // -travel .. +travel
              final bounce =
                  (1 - (t * 2 - 1).abs()) * 3; // tiny lift mid-travel

              final movingRight =
                  _controller.status == AnimationStatus.forward;

              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // Road
                  Positioned(
                    bottom: 18,
                    child: _DashedRoad(width: maxWidth * 0.9),
                  ),
                  // Car
                  Transform.translate(
                    offset: Offset(dx, -bounce),
                    child: Transform.flip(
                      flipX: movingRight,
                      child: Image.asset(
                        'assets/images/Car.png',
                        height: 110,
                        errorBuilder: (_, __, ___) => Icon(
                          Icons.local_shipping_outlined,
                          size: 90,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _DashedRoad extends StatelessWidget {
  final double width;

  const _DashedRoad({required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 4,
      child: CustomPaint(
        painter: _DashedLinePainter(color: AppColors.lightGrey.withOpacity(0.4)),
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final Color color;

  _DashedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    const dashWidth = 8.0;
    const dashSpace = 6.0;
    double startX = 0;
    final y = size.height / 2;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, y),
        Offset(startX + dashWidth, y),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant _DashedLinePainter oldDelegate) => false;
}
