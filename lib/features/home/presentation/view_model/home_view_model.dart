import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:florista_ecommerce_app/config/base_state/base_state.dart';
import 'package:florista_ecommerce_app/config/handler/response_to_state_mapper.dart';
import 'package:florista_ecommerce_app/features/home/domain/entities/best_seller_entity.dart';
import 'package:florista_ecommerce_app/features/home/domain/entities/category_entity.dart';
import 'package:florista_ecommerce_app/features/home/domain/use_cases/get_all_best_seller_use_case.dart';
import 'package:florista_ecommerce_app/features/home/domain/use_cases/get_all_categories_use_case.dart';
import 'package:florista_ecommerce_app/features/home/presentation/view_model/home_event.dart';
import 'package:injectable/injectable.dart';

part 'home_state.dart';

@injectable
class HomeViewModel extends Cubit<HomeState> {
  final GetAllCategoriesUseCase getAllCategoriesUseCase;
  final GetAllBestSellerUseCase getAllBestSellerUseCase;

  HomeViewModel({
    required this.getAllCategoriesUseCase,
    required this.getAllBestSellerUseCase,
  }) : super(HomeState());

  void doEvent(HomeEvent event) {
    switch (event) {
      case GetAllCategoriesEvent():
        _getAllCategories();
        break;
      case GetAllBestSellerEvent():
        _getAllBestSeller();
        break;
    }
  }

  Future<void> _getAllCategories() async {
    emit(
      state.copyWith(
        getAllCategoriesState: state.getAllCategoriesState.copyWith(
          isLoading: true,
          data: null,
          errorMessage: null,
        ),
      ),
    );

    final response = await getAllCategoriesUseCase();
    final handler = ResponseToStateMapper.handle(response);

    emit(
      state.copyWith(
        getAllCategoriesState: state.getAllCategoriesState.copyWith(
          isLoading: handler.isLoading,
          data: handler.data,
          errorMessage: handler.errorMessage,
        ),
      ),
    );
  }

  Future<void> _getAllBestSeller() async {
    emit(
      state.copyWith(
        getAllBestSellerState: state.getAllBestSellerState.copyWith(
          isLoading: true,
          data: null,
          errorMessage: null,
        ),
      ),
    );

    final response = await getAllBestSellerUseCase();
    final handler = ResponseToStateMapper.handle(response);

    emit(
      state.copyWith(
        getAllBestSellerState: state.getAllBestSellerState.copyWith(
          isLoading: handler.isLoading,
          data: handler.data,
          errorMessage: handler.errorMessage,
        ),
      ),
    );
  }
}
