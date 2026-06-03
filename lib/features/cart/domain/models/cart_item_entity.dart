import 'package:florista_ecommerce_app/config/shared_models/products/product_dto.dart';

class CartItemEntity {
  final Product product;
  final num price;
  final int quantity;
  final String id;

  CartItemEntity({
    required this.product,
    required this.price,
    required this.quantity,
    required this.id,
  });
}
