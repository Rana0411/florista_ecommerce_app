import 'package:flutter_test/flutter_test.dart';
import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/config/secure_storage/secure_storage_service.dart';
import 'package:florista_ecommerce_app/features/cart/data/data_sources/cart_remote_data_source_contract.dart';
import 'package:florista_ecommerce_app/features/cart/data/models/cart_dto.dart';
import 'package:florista_ecommerce_app/features/cart/data/models/cart_requests_model.dart';
import 'package:florista_ecommerce_app/features/cart/data/models/cart_response_model.dart';
import 'package:florista_ecommerce_app/features/cart/data/repo/cart_repo_impl.dart';
import 'package:florista_ecommerce_app/features/cart/domain/models/cart_response_entity.dart';

class _FakeCartRemoteDataSource implements CartRemoteDataSourceContract {
  BaseResponse<CartResponseModel>? getCartResult;
  BaseResponse<CartResponseModel>? addProductResult;
  BaseResponse<CartResponseModel>? removeProductResult;
  BaseResponse<CartResponseModel>? updateQuantityResult;
  BaseResponse<String>? clearCartResult;

  @override
  Future<BaseResponse<CartResponseModel>> getCart() async =>
      getCartResult ?? ErrorBaseResponse(errorMessage: 'not stubbed');

  @override
  Future<BaseResponse<CartResponseModel>> addProductToCart({
    required AddProductRequest productInfo,
  }) async =>
      addProductResult ?? ErrorBaseResponse(errorMessage: 'not stubbed');

  @override
  Future<BaseResponse<CartResponseModel>> removeProductFromCart({
    required String productId,
  }) async =>
      removeProductResult ?? ErrorBaseResponse(errorMessage: 'not stubbed');

  @override
  Future<BaseResponse<CartResponseModel>> updateProductQuantity({
    required String productId,
    required UpdateQuantityRequest quantity,
  }) async =>
      updateQuantityResult ?? ErrorBaseResponse(errorMessage: 'not stubbed');

  @override
  Future<BaseResponse<String>> clearCart() async =>
      clearCartResult ?? ErrorBaseResponse(errorMessage: 'not stubbed');
}

void main() {
  late _FakeCartRemoteDataSource dataSource;
  late CartRepoImpl repo;

  final cartModel = CartResponseModel(
    numOfCartItems: 1,
    cart: CartDto(
      id: 'cart-id',
      user: 'user-id',
      cartItems: [],
      appliedCoupons: [],
      discount: 0,
      totalPrice: 50,
      totalPriceAfterDiscount: 50,
    ),
  );

  setUp(() {
    dataSource = _FakeCartRemoteDataSource();
    repo = CartRepoImpl(
      cartRemoteDataSourceContract: dataSource,
      secureStorageService: SecureStorageService(),
    );
  });

  Future<void> expectSuccessCartMapping(
    Future<BaseResponse<CartResponseEntity>> Function() action,
  ) async {
    final response = await action();

    expect(response, isA<SuccessBaseResponse<CartResponseEntity>>());
    final success = response as SuccessBaseResponse<CartResponseEntity>;
    expect(success.data.numOfCartItems, 1);
    expect(success.data.cart.id, 'cart-id');
    expect(success.data.cart.user, 'user-id');
    expect(success.data.cart.totalPrice, 50);
  }

  group('CartRepoImpl', () {
    test('getCart maps success response to entity', () async {
      dataSource.getCartResult = SuccessBaseResponse(data: cartModel);

      await expectSuccessCartMapping(repo.getCart);
    });

    test('getCart propagates error response', () async {
      dataSource.getCartResult = ErrorBaseResponse(
        errorMessage: 'network error',
      );

      final response = await repo.getCart();

      expect(response, isA<ErrorBaseResponse<CartResponseEntity>>());
      expect(
        (response as ErrorBaseResponse<CartResponseEntity>).errorMessage,
        'network error',
      );
    });

    test('addProductToCart maps success response to entity', () async {
      dataSource.addProductResult = SuccessBaseResponse(data: cartModel);

      await expectSuccessCartMapping(
        () => repo.addProductToCart(
          AddProductRequest(productId: 'p1', quantity: 1),
        ),
      );
    });

    test('removeProductFromCart maps success response to entity', () async {
      dataSource.removeProductResult = SuccessBaseResponse(data: cartModel);

      await expectSuccessCartMapping(
        () => repo.removeProductFromCart('p1'),
      );
    });

    test('updateProductQuantity maps success response to entity', () async {
      dataSource.updateQuantityResult = SuccessBaseResponse(data: cartModel);

      await expectSuccessCartMapping(
        () => repo.updateProductQuantity(
          'p1',
          UpdateQuantityRequest(quantity: 2),
        ),
      );
    });

    test('clearCart returns message on success', () async {
      dataSource.clearCartResult = SuccessBaseResponse(data: 'Cart cleared');

      final response = await repo.clearCart();

      expect(response, isA<SuccessBaseResponse<String>>());
      expect((response as SuccessBaseResponse<String>).data, 'Cart cleared');
    });

    test('clearCart propagates error response', () async {
      dataSource.clearCartResult = ErrorBaseResponse(errorMessage: 'failed');

      final response = await repo.clearCart();

      expect(response, isA<ErrorBaseResponse<String>>());
      expect(
        (response as ErrorBaseResponse<String>).errorMessage,
        'failed',
      );
    });
  });
}
