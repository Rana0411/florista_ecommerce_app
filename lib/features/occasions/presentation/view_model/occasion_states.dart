part of 'occasion_cubit.dart';

class OccasionState extends Equatable {
  final BaseState<List<OccasionEntity>> occasionState;
  final BaseState<List<ProductEntity>> productState;
  final int selectedTabIndex;

  const OccasionState({
    BaseState<List<OccasionEntity>>? occasionState,
    BaseState<List<ProductEntity>>? productState,
    this.selectedTabIndex = 0,
  }) : occasionState =
           occasionState ??
           const BaseState<List<OccasionEntity>>(isLoading: true),
       productState =
           productState ??
           const BaseState<List<ProductEntity>>(isLoading: true);

  OccasionState copyWith({
    BaseState<List<OccasionEntity>>? occasionState,
    BaseState<List<ProductEntity>>? productState,
    int? selectedTabIndex,
  }) {
    return OccasionState(
      occasionState: occasionState ?? this.occasionState,
      productState: productState ?? this.productState,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
    );
  }

  @override
  List<Object?> get props => [occasionState, productState, selectedTabIndex];
}
