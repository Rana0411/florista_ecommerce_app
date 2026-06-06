import '../../../categories/domain/entities/product_entity.dart';

abstract class ProductDetailsRepoContract {
  Future<ProductEntity> getProductDetails(String productId);
}
