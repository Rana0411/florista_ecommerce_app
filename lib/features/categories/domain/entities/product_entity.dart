class ProductEntity {
  final String id;
  final String name;
  final String description;
  final String image;
  final List<String> images;

  /// Final price the customer pays (priceAfterDiscount from API)
  final double price;

  /// Original price before discount
  final double originalPrice;

  /// Absolute discount amount in currency (NOT a percentage)
  final int discountAmount;

  final double rateAvg;
  final int rateCount;
  final int sold;
  final int quantity;
  final String categoryId;
  final String occasionId;
  final bool isInWishlist;
  final DateTime createdAt;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.images,
    required this.price,
    required this.originalPrice,
    required this.discountAmount,
    required this.rateAvg,
    required this.rateCount,
    required this.sold,
    required this.quantity,
    required this.categoryId,
    required this.occasionId,
    required this.isInWishlist,
    required this.createdAt,
  });

  /// Returns true if the product has an active discount
  bool get hasDiscount => discountAmount > 0;

  /// Discount as a percentage for display (e.g. "25% off")
  double get discountPercent =>
      originalPrice > 0 ? (discountAmount / originalPrice) * 100 : 0;
}
