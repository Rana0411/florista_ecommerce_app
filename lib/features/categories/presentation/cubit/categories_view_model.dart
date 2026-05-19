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

    // selectedCategoryIndex starts at 0 ("All") — load all products.
    await _fetchProductsForSelectedCategory();
  }

  // ─── Category tab selection ────────────────────────────────────────────────

  /// [index] is the tab index where 0 = "All" and 1..n = categories[index-1].
  Future<void> selectCategory(int index) async {
    if (state.selectedCategoryIndex == index) return;
    // Reset search when switching categories.
    emit(state.copyWith(selectedCategoryIndex: index, searchQuery: ''));
    await _fetchProductsForSelectedCategory();
  }

  // ─── Products ──────────────────────────────────────────────────────────────

  Future<void> _fetchProductsForSelectedCategory() async {
    if (state.categories.isEmpty) return;

    emit(state.copyWith(
      isProductsLoading: true,
      clearProductsError: true,
    ));

    // index 0 is the "All" tab — fetch every category in parallel and merge.
    // index 1..n maps to categories[index - 1].
    List<ProductEntity> fetched = [];

    if (state.selectedCategoryIndex == 0) {
      final futures =
      state.categories.map((c) => _getProductsByCategoryUseCase(c.id));
      final responses = await Future.wait(futures);

      for (final response in responses) {
        if (response case SuccessBaseResponse()) {
          fetched.addAll(response.data);
        }
      }
    } else {
      final category = state.categories[state.selectedCategoryIndex - 1];
      final response = await _getProductsByCategoryUseCase(category.id);

      switch (response) {
        case SuccessBaseResponse():
          fetched = response.data;
        case ErrorBaseResponse():
          emit(state.copyWith(
            isProductsLoading: false,
            productsErrorMessage: response.errorMessage,
          ));
          return;
      }
    }

    final sorted = _applySorting(fetched, state.selectedSort);
    emit(state.copyWith(
      isProductsLoading: false,
      allProducts: fetched,
      products: sorted,
    ));
  }

  // ─── Sort ──────────────────────────────────────────────────────────────────

  void showSortSheet() => emit(state.copyWith(isSortSheetVisible: true));

  void hideSortSheet() => emit(state.copyWith(isSortSheetVisible: false));

  void applySort(SortOption sort) {
    // Sort the currently visible (search-filtered) products.
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

  /// Filters [allProducts] locally by name/description; preserves active sort.
  void searchProducts(String query) {
    final trimmed = query.trim().toLowerCase();
    final filtered = trimmed.isEmpty
        ? state.allProducts
        : state.allProducts
        .where((p) =>
    p.name.toLowerCase().contains(trimmed) ||
        p.description.toLowerCase().contains(trimmed))
        .toList();

    emit(state.copyWith(
      searchQuery: query,
      products: _applySorting(filtered, state.selectedSort),
    ));
  }
}