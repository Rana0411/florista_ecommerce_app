import 'package:bloc/bloc.dart';
import 'package:florista_ecommerce_app/features/product_details/presentation/cubit/product_details_state.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecase/get_product_details_use_case.dart';

@injectable
class ProductDetailsCubit
    extends Cubit<ProductDetailsState> {

  final GetProductDetailsUseCase useCase;

  ProductDetailsCubit(
      this.useCase,
      ) : super(ProductDetailsInitial());

  Future<void> getProduct(
      String id,
      ) async {
    emit(ProductDetailsLoading());

    try {
      final product =
      await useCase.call(id);

      emit(
        ProductDetailsSuccess(product),
      );
    } catch (e) {
      emit(
        ProductDetailsError(
          e.toString(),
        ),
      );
    }
  }
}