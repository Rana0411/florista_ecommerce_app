sealed class SavedAddressEvent {}

class GetSavedAddressesEvent extends SavedAddressEvent {}

class DeleteAddressEvent extends SavedAddressEvent {
  final String addressId;

  DeleteAddressEvent({required this.addressId});
}
