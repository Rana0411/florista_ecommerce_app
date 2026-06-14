import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/cart/data/data_sources/cart_remote_data_source_contract.dart';
import 'package:florista_ecommerce_app/features/cart/api/api_client/cart_api_client.dart';
import 'package:florista_ecommerce_app/features/cart/data/models/cart_requests_model.dart';
import 'package:florista_ecommerce_app/features/cart/data/models/cart_response_model.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartRemoteDataSourceContract)
class CartRemoteDataSourceImpl implements CartRemoteDataSourceContract {
  final CartApiClient apiClient;

  CartRemoteDataSourceImpl({required this.apiClient});
  //add product
  @override
  Future<BaseResponse<CartResponseModel>> addProductToCart({
    required AddProductRequest productInfo,
  }) async {
    try {
      final response = await apiClient.addProductToCart(productInfo);
      return SuccessBaseResponse<CartResponseModel>(data: response);
    } catch (e) {
      return ErrorBaseResponse<CartResponseModel>(errorMessage: e.toString());
    }
  }

  //clear cart
  @override
  Future<BaseResponse<String>> clearCart() async {
    try {
      final response = await apiClient.clearCart();
      return SuccessBaseResponse<String>(
        data: response.message ?? S.current.somethineWentWrong,
      );
    } catch (e) {
      return ErrorBaseResponse<String>(errorMessage: e.toString());
    }
  }

  //get cart
  @override
  Future<BaseResponse<CartResponseModel>> getCart() async {
    try {
      final response = await apiClient.getCart();
      return SuccessBaseResponse<CartResponseModel>(data: response);
    } catch (e) {
      return ErrorBaseResponse<CartResponseModel>(errorMessage: e.toString());
    }
  }

  //remove product
  @override
  Future<BaseResponse<CartResponseModel>> removeProductFromCart({
    required String productId,
  }) async {
    try {
      final response = await apiClient.removeProductFromCart(productId);
      return SuccessBaseResponse<CartResponseModel>(data: response);
    } catch (e) {
      return ErrorBaseResponse<CartResponseModel>(errorMessage: e.toString());
    }
  }

  //update product quantity
  @override
  Future<BaseResponse<CartResponseModel>> updateProductQuantity({
    required String productId,
    required UpdateQuantityRequest quantity,
  }) async {
    try {
      final response = await apiClient.updateProductQuantity(
        productId,
        quantity,
      );
      return SuccessBaseResponse<CartResponseModel>(data: response);
    } catch (e) {
      return ErrorBaseResponse<CartResponseModel>(errorMessage: e.toString());
    }
  }
}
