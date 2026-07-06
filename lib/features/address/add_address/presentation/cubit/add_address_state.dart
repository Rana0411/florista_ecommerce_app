part of 'add_address_view_model.dart';

class AddAddressState {
  BaseState<AddAddressResponse> addAddressState =
      BaseState<AddAddressResponse>(isLoading: false);

  BaseState<AddAddressResponse> getAddressesState =
      BaseState<AddAddressResponse>(isLoading: false);

  AddAddressState({
    BaseState<AddAddressResponse>? addAddressState,
    BaseState<AddAddressResponse>? getAddressesState,
  }) {
    this.addAddressState = addAddressState ?? this.addAddressState;
    this.getAddressesState = getAddressesState ?? this.getAddressesState;
  }

  AddAddressState copyWith({
    BaseState<AddAddressResponse>? addAddressState,
    BaseState<AddAddressResponse>? getAddressesState,
  }) {
    return AddAddressState(
      addAddressState: addAddressState ?? this.addAddressState,
      getAddressesState: getAddressesState ?? this.getAddressesState,
    );
  }
}
