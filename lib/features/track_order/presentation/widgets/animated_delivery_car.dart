import 'package:flutter/material.dart';

import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/features/track_order/presentation/widgets/dashed_road.dart';

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
          final travel = (constraints.maxWidth - 140) / 2;
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, _) => _buildScene(constraints.maxWidth, travel),
          );
        },
      ),
    );
  }

  Widget _buildScene(double maxWidth, double travel) {
    final t = Curves.easeInOut.transform(_controller.value);
    final dx = (t * 2 - 1) * travel; // -travel .. +travel
    final bounce = (1 - (t * 2 - 1).abs()) * 3; // tiny lift mid-travel
    final movingRight = _controller.status == AnimationStatus.forward;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Positioned(
          bottom: 18,
          child: DashedRoad(
            width: maxWidth * 0.9,
            color: AppColors.lightGrey.withOpacity(0.4),
          ),
        ),
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
  }
}
