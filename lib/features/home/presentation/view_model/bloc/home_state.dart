part of 'home_view_model.dart';

class HomeState extends Equatable {
  final BaseState<List<CategoryEntity>> getAllCategoriesState;
  HomeState({BaseState<List<CategoryEntity>>? getAllCategoriesState})
    : getAllCategoriesState =
          getAllCategoriesState ??
          BaseState<List<CategoryEntity>>(isLoading: true);

  HomeState copyWith({
    BaseState<List<CategoryEntity>>? getAllCategoriesState,
  }) => HomeState(
    getAllCategoriesState: getAllCategoriesState ?? this.getAllCategoriesState,
  );

  @override
  List<Object> get props => [getAllCategoriesState];
}
