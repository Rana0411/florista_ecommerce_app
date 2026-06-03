import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/cart/data/models/cart_requests_model.dart';
import 'package:florista_ecommerce_app/features/cart/domain/models/cart_response_entity.dart';

abstract interface class CartRepoContract {
  Future<BaseResponse<CartResponseEntity>> getCart();
  Future<BaseResponse<CartResponseEntity>> addProductToCart(
    AddProductRequest productInfo,
  );
  Future<BaseResponse<CartResponseEntity>> removeProductFromCart(
    String productId,
  );
  Future<BaseResponse<CartResponseEntity>> updateProductQuantity(
    String productId,
    UpdateQuantityRequest quantity,
  );
  Future<BaseResponse<String>> clearCart();
}
