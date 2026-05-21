import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/config/secure_storage/secure_storage_service.dart';
import 'package:florista_ecommerce_app/features/cart/data/models/cart_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:florista_ecommerce_app/features/cart/data/data_sources/cart_remote_data_source_contract.dart';
import 'package:florista_ecommerce_app/features/cart/data/models/cart_requests_model.dart';
import 'package:florista_ecommerce_app/features/cart/domain/models/cart_response_entity.dart';
import 'package:florista_ecommerce_app/features/cart/domain/repo/cart_repo_contract.dart';

@Injectable(as: CartRepoContract)
class CartRepoImpl implements CartRepoContract {
  CartRemoteDataSourceContract cartRemoteDataSourceContract;
  SecureStorageService secureStorageService;
  CartRepoImpl({
    required this.cartRemoteDataSourceContract,
    required this.secureStorageService,
  });

  @override
  Future<BaseResponse<CartResponseEntity>> addProductToCart(
    AddProductRequest productInfo,
  ) async {
    final response = await cartRemoteDataSourceContract.addProductToCart(
      productInfo: productInfo,
    );
    switch (response) {
      case SuccessBaseResponse<CartResponseModel> successResponse:
        final cartEntity = successResponse.data.toEntity();
        return SuccessBaseResponse<CartResponseEntity>(data: cartEntity);
      case ErrorBaseResponse<CartResponseModel> errorResponse:
        return ErrorBaseResponse<CartResponseEntity>(
          errorMessage: errorResponse.errorMessage,
        );
    }
  }

  @override
  Future<BaseResponse<String>> clearCart() async {
    final response = await cartRemoteDataSourceContract.clearCart();
    switch (response) {
      case SuccessBaseResponse<String> successResponse:
        return SuccessBaseResponse<String>(data: successResponse.data);
      case ErrorBaseResponse<String> errorResponse:
        return ErrorBaseResponse<String>(
          errorMessage: errorResponse.errorMessage,
        );
    }
  }

  @override
  Future<BaseResponse<CartResponseEntity>> getCart() async {
    final response = await cartRemoteDataSourceContract.getCart();
    switch (response) {
      case SuccessBaseResponse<CartResponseModel> successResponse:
        final cartEntity = successResponse.data.toEntity();
        return SuccessBaseResponse<CartResponseEntity>(data: cartEntity);
      case ErrorBaseResponse<CartResponseModel> errorResponse:
        return ErrorBaseResponse<CartResponseEntity>(
          errorMessage: errorResponse.errorMessage,
        );
    }
  }

  @override
  Future<BaseResponse<CartResponseEntity>> removeProductFromCart(
    String productId,
  ) async {
    final response = await cartRemoteDataSourceContract.removeProductFromCart(
      productId: productId,
    );
    switch (response) {
      case SuccessBaseResponse<CartResponseModel> successResponse:
        final cartEntity = successResponse.data.toEntity();
        return SuccessBaseResponse<CartResponseEntity>(data: cartEntity);
      case ErrorBaseResponse<CartResponseModel> errorResponse:
        return ErrorBaseResponse<CartResponseEntity>(
          errorMessage: errorResponse.errorMessage,
        );
    }
  }

  @override
  Future<BaseResponse<CartResponseEntity>> updateProductQuantity(
    String productId,
    UpdateQuantityRequest quantity,
  ) async {
    final response = await cartRemoteDataSourceContract.updateProductQuantity(
      productId: productId,
      quantity: quantity,
    );
    switch (response) {
      case SuccessBaseResponse<CartResponseModel> successResponse:
        final cartEntity = successResponse.data.toEntity();
        return SuccessBaseResponse<CartResponseEntity>(data: cartEntity);
      case ErrorBaseResponse<CartResponseModel> errorResponse:
        return ErrorBaseResponse<CartResponseEntity>(
          errorMessage: errorResponse.errorMessage,
        );
    }
  }
}
