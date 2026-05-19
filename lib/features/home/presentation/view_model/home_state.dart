part of 'home_view_model.dart';

class HomeState extends Equatable {
  final BaseState<List<CategoryEntity>> getAllCategoriesState;
  final BaseState<List<BestSellerEntity>> getAllBestSellerState;
  final BaseState<List<OccasionEntity>> getAllOccasionsState;
  final BaseState<List<AddressEntity>> getLoggedUserAddressesState;
  final String? selectedAddressId;

  const HomeState({
    BaseState<List<CategoryEntity>>? getAllCategoriesState,
    BaseState<List<BestSellerEntity>>? getAllBestSellerState,
    BaseState<List<OccasionEntity>>? getAllOccasionsState,
    BaseState<List<AddressEntity>>? getLoggedUserAddressesState,
    this.selectedAddressId,
  }) : getAllCategoriesState =
           getAllCategoriesState ??
           const BaseState<List<CategoryEntity>>(isLoading: true),
       getAllBestSellerState =
           getAllBestSellerState ??
           const BaseState<List<BestSellerEntity>>(isLoading: true),
       getAllOccasionsState =
           getAllOccasionsState ??
           const BaseState<List<OccasionEntity>>(isLoading: true),
       getLoggedUserAddressesState =
           getLoggedUserAddressesState ??
           const BaseState<List<AddressEntity>>(isLoading: true);

  HomeState copyWith({
    BaseState<List<CategoryEntity>>? getAllCategoriesState,
    BaseState<List<BestSellerEntity>>? getAllBestSellerState,
    BaseState<List<OccasionEntity>>? getAllOccasionsState,
    BaseState<List<AddressEntity>>? getLoggedUserAddressesState,
    String? selectedAddressId,
  }) => HomeState(
    getAllCategoriesState: getAllCategoriesState ?? this.getAllCategoriesState,
    getAllBestSellerState: getAllBestSellerState ?? this.getAllBestSellerState,
    getAllOccasionsState: getAllOccasionsState ?? this.getAllOccasionsState,
    getLoggedUserAddressesState:
        getLoggedUserAddressesState ?? this.getLoggedUserAddressesState,
    selectedAddressId: selectedAddressId ?? this.selectedAddressId,
  );

  @override
  List<Object?> get props => [
    getAllCategoriesState,
    getAllBestSellerState,
    getAllOccasionsState,
    getLoggedUserAddressesState,
    selectedAddressId,
  ];
}
