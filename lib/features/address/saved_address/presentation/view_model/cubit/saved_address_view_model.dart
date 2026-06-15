import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:florista_ecommerce_app/config/base_state/base_state.dart';
import 'package:florista_ecommerce_app/config/handler/response_to_state_mapper.dart';
import 'package:florista_ecommerce_app/features/address/saved_address/presentation/view_model/cubit/saved_address_event.dart';
import 'package:florista_ecommerce_app/features/home/domain/entities/address_entity.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/delete_address_use_case.dart';
import '../../../domain/use_cases/get_saved_addresses_use_case.dart';

part 'saved_address_state.dart';

@injectable
class SavedAddressViewModel extends Cubit<SavedAddressState> {
  final GetSavedAddressesUseCase getSavedAddressesUseCase;
  final DeleteAddressUseCase deleteAddressUseCase;

  SavedAddressViewModel({
    required this.getSavedAddressesUseCase,
    required this.deleteAddressUseCase,
  }) : super(SavedAddressState());

  void doEvent(SavedAddressEvent event) {
    switch (event) {
      case GetSavedAddressesEvent():
        _getSavedAddresses();
        break;
      case DeleteAddressEvent():
        _deleteAddress(addressId: event.addressId);
        break;
    }
  }

  Future<void> _getSavedAddresses() async {
    emit(
      state.copyWith(
        getSavedAddressesState: state.getSavedAddressesState.copyWith(
          isLoading: true,
          errorMessage: null,
        ),
      ),
    );

    final response = await getSavedAddressesUseCase();
    final handler = ResponseToStateMapper.handle(response);

    emit(
      state.copyWith(
        getSavedAddressesState: state.getSavedAddressesState.copyWith(
          isLoading: handler.isLoading,
          data: handler.data,
          errorMessage: handler.errorMessage,
        ),
      ),
    );
  }

  Future<void> _deleteAddress({required String addressId}) async {
    final response = await deleteAddressUseCase(addressId: addressId);
    final handler = ResponseToStateMapper.handle(response);

    emit(
      state.copyWith(
        getSavedAddressesState: state.getSavedAddressesState.copyWith(
          isLoading: handler.isLoading,
          data: handler.data,
          errorMessage: handler.errorMessage,
        ),
      ),
    );
  }
}
