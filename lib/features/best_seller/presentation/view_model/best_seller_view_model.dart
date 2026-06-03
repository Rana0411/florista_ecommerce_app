import 'package:florista_ecommerce_app/config/handler/response_to_state_mapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/use_cases/best_seller_use_cases.dart';
import 'best_seller_state.dart';

@injectable
class BestSellerViewModel extends Cubit<BestSellerState> {
  final GetBestSellerUseCase _getBestSellerUseCase;

  BestSellerViewModel({
    required GetBestSellerUseCase getBestSellerUseCase,
  })  : _getBestSellerUseCase = getBestSellerUseCase,
        super(const BestSellerState());

  Future<void> getBestSeller() async {
    emit(state.copyWith(isLoading: true, clearError: true));

    final response = await _getBestSellerUseCase();
    final mapped = ResponseToStateMapper.handle(response);

    emit(state.copyWith(
      isLoading: false,
      products: mapped.data ?? [],
      errorMessage: mapped.errorMessage,
    ));
  }
}