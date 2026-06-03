import 'package:equatable/equatable.dart';

import 'package:florista_ecommerce_app/features/categories/domain/entities/categories_entity.dart';
import 'package:florista_ecommerce_app/features/categories/domain/entities/product_entity.dart';

export 'package:florista_ecommerce_app/features/categories/domain/entities/product_entity.dart';

enum SortOption { lowestPrice, highestPrice, newest, oldest, discount }

class CategoriesState extends Equatable {
  final bool isLoading;
  final List<CategoriesEntity> categories;
  final String? errorMessage;

  // Products grid state
  final bool isProductsLoading;
  /// Displayed products (after search filter + sort applied).
  final List<ProductEntity> products;
  /// Full unfiltered product list for the selected category – used for search.
  final List<ProductEntity> allProducts;
  final String? productsErrorMessage;

  // Filtering & sorting
  /// 0 = "All", 1..n = categories[index - 1]
  final int selectedCategoryIndex;
  final SortOption? selectedSort;
  final bool isSortSheetVisible;

  // Search
  final String searchQuery;

  const CategoriesState({
    this.isLoading = false,
    this.categories = const [],
    this.errorMessage,
    this.isProductsLoading = false,
    this.products = const [],
    this.allProducts = const [],
    this.productsErrorMessage,
    this.selectedCategoryIndex = 0,
    this.selectedSort,
    this.isSortSheetVisible = false,
    this.searchQuery = '',
  });

  CategoriesState copyWith({
    bool? isLoading,
    List<CategoriesEntity>? categories,
    String? errorMessage,
    bool clearError = false,
    bool? isProductsLoading,
    List<ProductEntity>? products,
    List<ProductEntity>? allProducts,
    String? productsErrorMessage,
    bool clearProductsError = false,
    int? selectedCategoryIndex,
    SortOption? selectedSort,
    bool clearSort = false,
    bool? isSortSheetVisible,
    String? searchQuery,
  }) {
    return CategoriesState(
      isLoading: isLoading ?? this.isLoading,
      categories: categories ?? this.categories,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      isProductsLoading: isProductsLoading ?? this.isProductsLoading,
      products: products ?? this.products,
      allProducts: allProducts ?? this.allProducts,
      productsErrorMessage: clearProductsError
          ? null
          : productsErrorMessage ?? this.productsErrorMessage,
      selectedCategoryIndex:
      selectedCategoryIndex ?? this.selectedCategoryIndex,
      selectedSort: clearSort ? null : selectedSort ?? this.selectedSort,
      isSortSheetVisible: isSortSheetVisible ?? this.isSortSheetVisible,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    categories,
    errorMessage,
    isProductsLoading,
    products,
    allProducts,
    productsErrorMessage,
    selectedCategoryIndex,
    selectedSort,
    isSortSheetVisible,
    searchQuery,
  ];
}

