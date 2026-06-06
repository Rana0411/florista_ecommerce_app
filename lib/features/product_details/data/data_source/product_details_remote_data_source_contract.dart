import '../../../categories/domain/entities/product_entity.dart';

abstract class ProductDetailsRemoteDataSourceContract {
  Future<ProductEntity> getProductDetails(
      String productId,
      );
}