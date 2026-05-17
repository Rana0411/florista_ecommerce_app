import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:florista_ecommerce_app/config/base_state/base_state.dart';
import 'package:florista_ecommerce_app/config/handler/response_to_state_mapper.dart';
import 'package:florista_ecommerce_app/config/shared_models/entities/product_entity.dart';
import 'package:florista_ecommerce_app/config/shared_models/tab_item_.dart';
import 'package:florista_ecommerce_app/features/occasions/domain/models/occasion_entity.dart';
import 'package:florista_ecommerce_app/features/occasions/domain/use_cases/get_all_occasions_use_case.dart';
import 'package:florista_ecommerce_app/features/occasions/domain/use_cases/get_products_of_occasion.dart';
import 'package:injectable/injectable.dart';

part 'occasion_states.dart';

@injectable
class OccasionCubit extends Cubit<OccasionState> {
  OccasionCubit({
    required this.getOccasionsUseCase,
    required this.getProductsOfOccasion,
  }) : super(OccasionState());

  final GetAllOccasionsUseCase getOccasionsUseCase;
  final GetProductsOfOccasion getProductsOfOccasion;

  /// Builds tab labels + ids from loaded occasions (no extra API call).
  List<TabItem> get tabItems {
    final occasions = state.occasionState.data;
    if (occasions == null) return [];

    return occasions
        .where((e) => e.id != null && e.id!.isNotEmpty)
        .map((occasion) => TabItem(name: occasion.name ?? '', id: occasion.id!))
        .toList();
  }

  /// Step 1: load all occasions, then load products for the first tab.
  Future<void> getAllOccasions() async {
    print('=== DEBUG: 1. getAllOccasions started ===');
    emit(
      state.copyWith(
        occasionState: state.occasionState.copyWith(
          isLoading: true,
          clearData: true,
          clearError: true,
        ),
      ),
    );

    final response = await getOccasionsUseCase.call();
    final handler = ResponseToStateMapper.handle(response);

    emit(
      state.copyWith(
        occasionState: state.occasionState.copyWith(
          isLoading: handler.isLoading,
          data: handler.data,
          errorMessage: handler.errorMessage,
          clearError: handler.errorMessage == null,
        ),
      ),
    );

    final occasions = handler.data;
    if (occasions != null && occasions.isNotEmpty) {
      await onTabSelected(0);
    }
  }

  /// Step 2: user taps a tab (or we auto-select index 0 after occasions load).
  Future<void> onTabSelected(int index) async {
    final occasions = state.occasionState.data;

    if (occasions == null || index >= occasions.length) return;

    final occasionId = occasions[index].id;

    print('Selected occasion id: $occasionId');

    if (occasionId == null || occasionId.isEmpty) {
      print('ERROR: empty occasion id');
      return;
    }

    emit(state.copyWith(selectedTabIndex: index));
    await getProductsOfOccasions(occasionId);
  }

  /// Loads products for one occasion id.
  Future<void> getProductsOfOccasions(String occasionId) async {
    emit(
      state.copyWith(
        productState: state.productState.copyWith(
          isLoading: true,
          clearData: true,
          clearError: true,
        ),
      ),
    );

    try {
      final response = await getProductsOfOccasion.call(occasionId);
      final handler = ResponseToStateMapper.handle(response);

      emit(
        state.copyWith(
          productState: state.productState.copyWith(
            isLoading: handler.isLoading,
            data: handler.data,
            errorMessage: handler.errorMessage,
            clearError: handler.errorMessage == null,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          productState: state.productState.copyWith(
            isLoading: false,
            clearData: true,
            errorMessage: e.toString(),
          ),
        ),
      );
    }
  }
}
