part of 'product_card.dart';

class PriceSection extends StatelessWidget {
  final ProductEntity product;

  const PriceSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final hasDiscount =
        product.price != null &&
        product.priceAfterDiscount != null &&
        product.price != product.priceAfterDiscount;

    return Wrap(
      spacing: 6,
      runSpacing: 4,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          '${S.current.EGB} ${product.priceAfterDiscount ?? product.price ?? 0}',
          style: const TextStyle(
            fontWeight: FontWeightManager.semiBold,
            fontSize: FontSize.s14,
          ),
        ),

        if (hasDiscount)
          Text(
            '${S.current.EGB} ${product.price}',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.grey,
              decoration: TextDecoration.lineThrough,
            ),
          ),

        if ((product.discount ?? 0) > 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '${product.discount}%',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.success,
                fontWeight: FontWeightManager.semiBold,
              ),
            ),
          ),
      ],
    );
  }
}
