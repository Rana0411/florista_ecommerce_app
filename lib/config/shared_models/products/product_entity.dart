class ProductEntity {
  final String image;
  final String title;
  final double price;
  final double oldPrice;
  final int discount;
  final String id;
  final int quantity;

  ProductEntity({
    required this.image,
    required this.title,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.id,
    required this.quantity,
  });
}
