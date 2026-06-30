import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class OrderSuccessIcon extends StatelessWidget {
  const OrderSuccessIcon({super.key});

  static const double _outerSize = 128;
  static const double _middleSize = 100;
  static const double _innerSize = 74;
  static const double _checkSize = 50;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: _outerSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _SuccessCircle(size: _outerSize, opacity: .12),
          _SuccessCircle(size: _middleSize, opacity: .16),
          _SuccessCircle(size: _innerSize, opacity: .22),
          Container(
            width: _checkSize,
            height: _checkSize,
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(.42),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check, color: AppColors.white, size: 30),
          ),
        ],
      ),
    );
  }
}

class _SuccessCircle extends StatelessWidget {
  const _SuccessCircle({
    required this.size,
    required this.opacity,
  });

  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.success.withOpacity(opacity),
        shape: BoxShape.circle,
      ),
    );
  }
}