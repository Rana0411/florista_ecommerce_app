import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/config/base_state/base_state.dart';
import 'package:florista_ecommerce_app/features/address/add_address/data/models/responsess/add_address_response.dart';
import 'package:florista_ecommerce_app/features/address/add_address/domain/use_cases/add_address_use_cases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'add_address_state.dart';

@injectable
class AddAddressViewModel extends Cubit<AddAddressState> {
  final AddAddressUseCase addAddressUseCase;
  final GetAddressesUseCase getAddressesUseCase;

  AddAddressViewModel({
    required this.addAddressUseCase,
    required this.getAddressesUseCase,
  }) : super(AddAddressState());

  Future<void> addAddress({
    required String street,
    required String phone,
    required String city,
    String lat = '',
    String long = '',
  }) async {
    emit(
      state.copyWith(
        addAddressState: state.addAddressState.copyWith(isLoading: true),
      ),
    );

    final response = await addAddressUseCase({
      'street': street,
      'phone': phone,
      'city': city,
      'lat': lat,
      'long': long,
    });

    switch (response) {
      case SuccessBaseResponse<AddAddressResponse>():
        emit(
          state.copyWith(
            addAddressState: state.addAddressState.copyWith(
              isLoading: false,
              data: response.data,
            ),
          ),
        );
        break;
      case ErrorBaseResponse<AddAddressResponse>():
        emit(
          state.copyWith(
            addAddressState: state.addAddressState.copyWith(
              isLoading: false,
              errorMessage: response.errorMessage,
            ),
          ),
        );
        break;
    }
  }

  Future<void> getAddresses() async {
    emit(
      state.copyWith(
        getAddressesState:
            state.getAddressesState.copyWith(isLoading: true),
      ),
    );

    final response = await getAddressesUseCase();

    switch (response) {
      case SuccessBaseResponse<AddAddressResponse>():
        emit(
          state.copyWith(
            getAddressesState: state.getAddressesState.copyWith(
              isLoading: false,
              data: response.data,
            ),
          ),
        );
        break;
      case ErrorBaseResponse<AddAddressResponse>():
        emit(
          state.copyWith(
            getAddressesState: state.getAddressesState.copyWith(
              isLoading: false,
              errorMessage: response.errorMessage,
            ),
          ),
        );
        break;
    }
  }
}
