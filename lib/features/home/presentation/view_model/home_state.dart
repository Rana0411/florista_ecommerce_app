part of 'home_view_model.dart';

class HomeState extends Equatable {
  final BaseState<List<CategoryEntity>> getAllCategoriesState;
  final BaseState<List<BestSellerEntity>> getAllBestSellerState;
  HomeState({
    BaseState<List<CategoryEntity>>? getAllCategoriesState,
    BaseState<List<BestSellerEntity>>? getAllBestSellerState,
  }) : getAllCategoriesState =
           getAllCategoriesState ??
           BaseState<List<CategoryEntity>>(isLoading: true),
       getAllBestSellerState =
           getAllBestSellerState ??
           BaseState<List<BestSellerEntity>>(isLoading: true);

  HomeState copyWith({
    BaseState<List<CategoryEntity>>? getAllCategoriesState,
    BaseState<List<BestSellerEntity>>? getAllBestSellerState,
  }) => HomeState(
    getAllCategoriesState: getAllCategoriesState ?? this.getAllCategoriesState,
    getAllBestSellerState: getAllBestSellerState ?? this.getAllBestSellerState,
  );

  @override
  List<Object> get props => [getAllCategoriesState, getAllBestSellerState];
}
