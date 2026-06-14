import 'package:equatable/equatable.dart';
import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/config/base_state/base_state.dart';
import 'package:florista_ecommerce_app/config/handler/response_to_state_mapper.dart';
import 'package:florista_ecommerce_app/features/cart/data/models/cart_requests_model.dart';
import 'package:florista_ecommerce_app/features/cart/domain/models/cart_item_entity.dart';
import 'package:florista_ecommerce_app/features/cart/domain/models/cart_response_entity.dart';
import 'package:florista_ecommerce_app/features/cart/domain/use_cases/add_product_to_cart_use_case.dart';
import 'package:florista_ecommerce_app/features/cart/domain/use_cases/clear_cart_use_case.dart';
import 'package:florista_ecommerce_app/features/cart/domain/use_cases/get_cart_use_case.dart';
import 'package:florista_ecommerce_app/features/cart/domain/use_cases/remove_product_from_cart_use_case.dart';
import 'package:florista_ecommerce_app/features/cart/domain/use_cases/update_product_quantity_use_case.dart';
import 'package:florista_ecommerce_app/features/cart/presentation/view/data/cart_empty_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
part 'cart_states.dart';

@injectable
class CartCubit extends Cubit<CartState> {
  CartCubit({
    required this.getCartUseCase,
    required this.addProductToCartUseCase,
    required this.removeProductFromCartUseCase,
    required this.updateProductQuantityUseCase,
    required this.clearCartUseCase,
  }) : super(CartState(cartState: BaseState()));

  final GetCartUseCase getCartUseCase;
  final AddProductToCartUseCase addProductToCartUseCase;
  final RemoveProductFromCartUseCase removeProductFromCartUseCase;
  final UpdateProductQuantityUseCase updateProductQuantityUseCase;
  final ClearCartUseCase clearCartUseCase;

  Future<void> getCart() async {
    emit(state.copyWith(cartState: state.cartState.copyWith(isLoading: true)));
    final response = await getCartUseCase();

    switch (response) {
      case SuccessBaseResponse<CartResponseEntity>():
        emit(
          state.copyWith(
            cartState: ResponseToStateMapper.handle<CartResponseEntity>(
              response,
            ),
            clearBusyRowId: true,
          ),
        );
      case ErrorBaseResponse<CartResponseEntity>():
        emit(
          state.copyWith(
            cartState: BaseState(
              data: CartEmptyData.response,
              isLoading: false,
              errorMessage: response.errorMessage,
            ),
            clearBusyRowId: true,
          ),
        );
    }
  }

  Future<void> addProductToCart(AddProductRequest productInfo) async {
    emit(state.copyWith(busyRowId: productInfo.productId));
    final response = await addProductToCartUseCase(productInfo);

    emit(
      state.copyWith(
        cartState: ResponseToStateMapper.handle<CartResponseEntity>(response),
        clearBusyRowId: true,
      ),
    );
  }

  Future<void> removeProductFromCart(String productId) async {
    emit(state.copyWith(busyRowId: productId));
    final response = await removeProductFromCartUseCase(productId);

    emit(
      state.copyWith(
        cartState: ResponseToStateMapper.handle<CartResponseEntity>(response),
        clearBusyRowId: true,
      ),
    );
  }

  Future<void> updateProductQuantity(
    String productId,
    UpdateQuantityRequest newQuantity,
  ) async {
    emit(state.copyWith(busyRowId: productId));
    final response = await updateProductQuantityUseCase(productId, newQuantity);

    emit(
      state.copyWith(
        cartState: ResponseToStateMapper.handle<CartResponseEntity>(response),
        clearBusyRowId: true,
      ),
    );
  }

  Future<void> incrementItem(CartItemEntity item) async {
    await updateProductQuantity(
      item.product.productId,
      UpdateQuantityRequest(quantity: item.quantity + 1),
    );
  }

  Future<void> decrementItem(CartItemEntity item) async {
    if (item.quantity <= 1) {
      await removeProductFromCart(item.product.productId);
      return;
    }

    await updateProductQuantity(
      item.product.productId,
      UpdateQuantityRequest(quantity: item.quantity - 1),
    );
  }

  Future<void> clearCart() async {
    emit(state.copyWith(cartState: state.cartState.copyWith(isLoading: true)));
    final response = await clearCartUseCase();

    switch (response) {
      case SuccessBaseResponse<String>():
        await getCart();

        emit(
          state.copyWith(
            cartState: state.cartState.copyWith(isLoading: false),
            message: response.data,
          ),
        );
      case ErrorBaseResponse<String>():
        {
          emit(
            state.copyWith(
              cartState: state.cartState.copyWith(
                isLoading: false,
                errorMessage: response.errorMessage,
              ),
            ),
          );
        }
    }
  }
}
