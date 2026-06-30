class ProductEntity {
  final String id;
  final String image;
  final String title;
  final double price;
  final double oldPrice;
  final int discount;

  ProductEntity({
    required this.image,
    required this.title,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.id,
  });
}
