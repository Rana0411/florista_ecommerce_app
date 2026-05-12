sealed class HomeEvent {}

class GetAllCategoriesEvent extends HomeEvent {}

class GetAllBestSellerEvent extends HomeEvent {}

class GetAllOccasionsEvent extends HomeEvent {}

class GetLoggedUserAddressesEvent extends HomeEvent {
  final String token;

  GetLoggedUserAddressesEvent({required this.token});
}
