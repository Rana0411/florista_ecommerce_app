import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:florista_ecommerce_app/config/base_state/base_state.dart';
import 'package:florista_ecommerce_app/config/handler/response_to_state_mapper.dart';
import 'package:florista_ecommerce_app/features/home/domain/entities/address_entity.dart';
import 'package:florista_ecommerce_app/features/home/domain/entities/best_seller_entity.dart';
import 'package:florista_ecommerce_app/features/home/domain/entities/category_entity.dart';
import 'package:florista_ecommerce_app/features/home/domain/entities/occasion_entity.dart';
import 'package:florista_ecommerce_app/features/home/domain/use_cases/get_all_best_seller_use_case.dart';
import 'package:florista_ecommerce_app/features/home/domain/use_cases/get_all_categories_use_case.dart';
import 'package:florista_ecommerce_app/features/home/domain/use_cases/get_all_occasions_use_case.dart';
import 'package:florista_ecommerce_app/features/home/domain/use_cases/get_logged_user_addresses_use_case.dart';
import 'package:florista_ecommerce_app/features/home/presentation/view_model/home_event.dart';
import 'package:injectable/injectable.dart';

part 'home_state.dart';

@injectable
class HomeViewModel extends Cubit<HomeState> {
  final GetAllCategoriesUseCase getAllCategoriesUseCase;
  final GetAllBestSellerUseCase getAllBestSellerUseCase;
  final GetAllOccasionsUseCase getAllOccasionsUseCase;
  final GetLoggedUserAddressesUseCase getLoggedUserAddressesUseCase;

  HomeViewModel({
    required this.getAllCategoriesUseCase,
    required this.getAllBestSellerUseCase,
    required this.getAllOccasionsUseCase,
    required this.getLoggedUserAddressesUseCase,
  }) : super(HomeState());

  void doEvent(HomeEvent event) {
    switch (event) {
      case GetAllCategoriesEvent():
        _getAllCategories();
        break;
      case GetAllBestSellerEvent():
        _getAllBestSeller();
        break;
      case GetAllOccasionsEvent():
        _getAllOccasions();
        break;
      case GetLoggedUserAddressesEvent():
        _getLoggedUserAddresses(token: event.token);
        break;
      case HomeInitEvent():
        _homeInit(token: event.token);
        break;
      case SelectAddressEvent():
        _selectAddress(event.value);
        break;
    }
  }

  Future<void> _homeInit({required String token}) async {
    await Future.wait([
      _getAllCategories(),
      _getAllBestSeller(),
      _getAllOccasions(),
      _getLoggedUserAddresses(token: token),
    ]);
  }

  void _selectAddress(String value) {
    emit(state.copyWith(selectedAddressId: value));
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

  Future<void> _getAllOccasions() async {
    emit(
      state.copyWith(
        getAllOccasionsState: state.getAllOccasionsState.copyWith(
          isLoading: true,
          data: null,
          errorMessage: null,
        ),
      ),
    );

    final response = await getAllOccasionsUseCase();
    final handler = ResponseToStateMapper.handle(response);

    emit(
      state.copyWith(
        getAllOccasionsState: state.getAllOccasionsState.copyWith(
          isLoading: handler.isLoading,
          data: handler.data,
          errorMessage: handler.errorMessage,
        ),
      ),
    );
  }

  Future<void> _getLoggedUserAddresses({required String token}) async {
    emit(
      state.copyWith(
        getLoggedUserAddressesState: state.getLoggedUserAddressesState.copyWith(
          isLoading: true,
          data: null,
          errorMessage: null,
        ),
      ),
    );

    final response = await getLoggedUserAddressesUseCase(token: token);
    final handler = ResponseToStateMapper.handle(response);

    emit(
      state.copyWith(
        getLoggedUserAddressesState: state.getLoggedUserAddressesState.copyWith(
          isLoading: handler.isLoading,
          data: handler.data,
          errorMessage: handler.errorMessage,
        ),
        selectedAddressId: handler.data?.isNotEmpty == true
            ? handler.data!.first.id
            : null,
      ),
    );
  }
}
