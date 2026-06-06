import '../../../categories/domain/entities/product_entity.dart';

sealed class ProductDetailsState {}

class ProductDetailsInitial
    extends ProductDetailsState {}

class ProductDetailsLoading
    extends ProductDetailsState {}

class ProductDetailsSuccess
    extends ProductDetailsState {
  final ProductEntity product;

  ProductDetailsSuccess(this.product);
}

class ProductDetailsError
    extends ProductDetailsState {
  final String message;

  ProductDetailsError(this.message);
}