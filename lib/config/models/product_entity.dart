class ProductEntity {
  final String name;
  final int price;
  final int priceAfterDiscount;
  final int discount;
  final String imageCover;

  ProductEntity({
    required this.name,
    required this.price,
    required this.priceAfterDiscount,
    required this.discount,
    required this.imageCover,
  });
}
