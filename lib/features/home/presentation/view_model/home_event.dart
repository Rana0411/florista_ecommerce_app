sealed class HomeEvent {}

class GetAllCategoriesEvent extends HomeEvent {}

class GetAllBestSellerEvent extends HomeEvent {}

class GetAllOccasionsEvent extends HomeEvent {}

class GetLoggedUserAddressesEvent extends HomeEvent {}

class HomeInitEvent extends HomeEvent {}

class SelectAddressEvent extends HomeEvent {
  final String value;

  SelectAddressEvent({required this.value});
}
