part of 'saved_address_view_model.dart';

class SavedAddressState extends Equatable {
  final BaseState<List<AddressEntity>> getSavedAddressesState;

  SavedAddressState({BaseState<List<AddressEntity>>? getSavedAddressesState})
    : getSavedAddressesState =
          getSavedAddressesState ??
          const BaseState<List<AddressEntity>>(isLoading: true);

  SavedAddressState copyWith({
    BaseState<List<AddressEntity>>? getSavedAddressesState,
  }) {
    return SavedAddressState(
      getSavedAddressesState:
          getSavedAddressesState ?? this.getSavedAddressesState,
    );
  }

  @override
  List<Object?> get props => [getSavedAddressesState];
}
