import 'package:flutter/material.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';

class ProductImageCarousel extends StatefulWidget {
  final List<String> images;
  final VoidCallback? onBack;

  const ProductImageCarousel({super.key, required this.images, this.onBack});

  @override
  State<ProductImageCarousel> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarousel> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 420,
          child: PageView.builder(
            onPageChanged: (index) => setState(() => currentIndex = index),
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return Image.network(
                widget.images[index],
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Icon(
                  Icons.local_florist,
                  size: 120,
                  color: AppColors.primary,
                ),
              );
            },
          ),
        ),
        Positioned(
          top: 48,
          left: 16,
          child: GestureDetector(
            onTap: widget.onBack ?? () => Navigator.of(context).pop(),
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
                ],
              ),
              child: const Icon(Icons.arrow_back_ios_new, size: 18),
            ),
          ),
        ),
        if (widget.images.length > 1)
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.images.length,
                    (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: currentIndex == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: currentIndex == index
                        ? AppColors.primary
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
