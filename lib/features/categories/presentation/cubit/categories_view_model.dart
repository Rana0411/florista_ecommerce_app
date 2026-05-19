import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/config/handler/response_to_state_mapper.dart';
import 'package:florista_ecommerce_app/features/categories/domain/use_cases/categories_use_cases.dart';
import 'package:florista_ecommerce_app/features/categories/domain/use_cases/get_products_by_category_use_case.dart';

import 'categories_state.dart';

@injectable
class CategoriesCubit extends Cubit<CategoriesState> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  final GetProductsByCategoryUseCase _getProductsByCategoryUseCase;

  CategoriesCubit({
    required GetCategoriesUseCase getCategoriesUseCase,
    required GetProductsByCategoryUseCase getProductsByCategoryUseCase,
  })  : _getCategoriesUseCase = getCategoriesUseCase,
        _getProductsByCategoryUseCase = getProductsByCategoryUseCase,
        super(const CategoriesState());

  // ─── Categories ────────────────────────────────────────────────────────────

  Future<void> getCategories() async {
    emit(state.copyWith(isLoading: true, clearError: true));

    final response = await _getCategoriesUseCase();
    final mapped = ResponseToStateMapper.handle(response);

    emit(state.copyWith(
      isLoading: false,
      categories: mapped.data ?? [],
      errorMessage: mapped.errorMessage,
    ));

    // Load products for the initially-selected category.
    await _fetchProductsForSelectedCategory();
  }

  // ─── Category tab selection ────────────────────────────────────────────────

  Future<void> selectCategory(int index) async {
    if (state.selectedCategoryIndex == index) return;
    emit(state.copyWith(selectedCategoryIndex: index));
    await _fetchProductsForSelectedCategory();
  }

  // ─── Products ──────────────────────────────────────────────────────────────

  Future<void> _fetchProductsForSelectedCategory() async {
    if (state.categories.isEmpty) return;

    emit(state.copyWith(
      isProductsLoading: true,
      clearProductsError: true,
    ));

    final selectedCategory = state.categories[state.selectedCategoryIndex];
    final response =
        await _getProductsByCategoryUseCase(selectedCategory.id);

    switch (response) {
      case SuccessBaseResponse():
        emit(state.copyWith(
          isProductsLoading: false,
          products: _applySorting(response.data, state.selectedSort),
        ));

      case ErrorBaseResponse():
        emit(state.copyWith(
          isProductsLoading: false,
          productsErrorMessage: response.errorMessage,
        ));
    }
  }

  // ─── Sort ──────────────────────────────────────────────────────────────────

  void showSortSheet() => emit(state.copyWith(isSortSheetVisible: true));

  void hideSortSheet() => emit(state.copyWith(isSortSheetVisible: false));

  void applySort(SortOption sort) {
    final sorted = _applySorting(state.products, sort);
    emit(state.copyWith(
      selectedSort: sort,
      products: sorted,
      isSortSheetVisible: false,
    ));
  }

  List<ProductEntity> _applySorting(
      List<ProductEntity> products, SortOption? sort) {
    final list = List<ProductEntity>.from(products);
    switch (sort) {
      case SortOption.lowestPrice:
        list.sort((a, b) => a.price.compareTo(b.price));
      case SortOption.highestPrice:
        list.sort((a, b) => b.price.compareTo(a.price));
      case SortOption.newest:
        list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      case SortOption.oldest:
        list.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      case SortOption.discount:
        list.sort((a, b) => b.discountAmount.compareTo(a.discountAmount));
      case null:
        break;
    }
    return list;
  }

  // ─── Search ────────────────────────────────────────────────────────────────

  void searchProducts(String query) {
    // Placeholder – hook up to a search use-case when available.
  }
}