part of 'home_view_model.dart';

class HomeState extends Equatable {
  final BaseState<List<CategoryEntity>> getAllCategoriesState;
  final BaseState<List<BestSellerEntity>> getAllBestSellerState;
  final BaseState<List<OccasionEntity>> getAllOccasionsState;
  HomeState({
    BaseState<List<CategoryEntity>>? getAllCategoriesState,
    BaseState<List<BestSellerEntity>>? getAllBestSellerState,
    BaseState<List<OccasionEntity>>? getAllOccasionsState,
  }) : getAllCategoriesState =
           getAllCategoriesState ??
           BaseState<List<CategoryEntity>>(isLoading: true),
       getAllBestSellerState =
           getAllBestSellerState ??
           BaseState<List<BestSellerEntity>>(isLoading: true),
       getAllOccasionsState =
           getAllOccasionsState ??
           BaseState<List<OccasionEntity>>(isLoading: true);

  HomeState copyWith({
    BaseState<List<CategoryEntity>>? getAllCategoriesState,
    BaseState<List<BestSellerEntity>>? getAllBestSellerState,
    BaseState<List<OccasionEntity>>? getAllOccasionsState,
  }) => HomeState(
    getAllCategoriesState: getAllCategoriesState ?? this.getAllCategoriesState,
    getAllBestSellerState: getAllBestSellerState ?? this.getAllBestSellerState,
    getAllOccasionsState: getAllOccasionsState ?? this.getAllOccasionsState,
  );

  @override
  List<Object> get props => [
    getAllCategoriesState,
    getAllBestSellerState,
    getAllOccasionsState,
  ];
}
