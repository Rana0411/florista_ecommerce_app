import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/cart/data/models/cart_requests_model.dart';
import 'package:florista_ecommerce_app/features/cart/data/models/cart_response_model.dart';

abstract interface class CartRemoteDataSourceContract {
  Future<BaseResponse<CartResponseModel>> getCart();

  Future<BaseResponse<String>> clearCart();

  Future<BaseResponse<CartResponseModel>> updateProductQuantity({
    required String productId,
    required UpdateQuantityRequest quantity,
  });

  Future<BaseResponse<CartResponseModel>> addProductToCart({
    required AddProductRequest productInfo,
  });

  Future<BaseResponse<CartResponseModel>> removeProductFromCart({
    required String productId,
  });
}
