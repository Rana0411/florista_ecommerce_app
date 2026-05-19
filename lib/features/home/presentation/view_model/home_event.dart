sealed class HomeEvent {}

class GetAllCategoriesEvent extends HomeEvent {}

class GetAllBestSellerEvent extends HomeEvent {}

class GetAllOccasionsEvent extends HomeEvent {}

class GetLoggedUserAddressesEvent extends HomeEvent {
  final String token;

  GetLoggedUserAddressesEvent({required this.token});
}

class HomeInitEvent extends HomeEvent {
  final String token;

  HomeInitEvent({required this.token});
}

class SelectAddressEvent extends HomeEvent {
  final String value;

  SelectAddressEvent({required this.value});
}
