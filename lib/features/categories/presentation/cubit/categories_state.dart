import 'package:equatable/equatable.dart';

import 'package:florista_ecommerce_app/features/categories/domain/entities/categories-entity.dart';
import 'package:florista_ecommerce_app/features/categories/domain/entities/product_entity.dart';

export 'package:florista_ecommerce_app/features/categories/domain/entities/product_entity.dart';

enum SortOption { lowestPrice, highestPrice, newest, oldest, discount }

class CategoriesState extends Equatable {
  final bool isLoading;
  final List<CategoryEntity> categories;
  final String? errorMessage;

  // Products grid state
  final bool isProductsLoading;
  final List<ProductEntity> products;
  final String? productsErrorMessage;

  // Filtering & sorting
  final int selectedCategoryIndex;
  final SortOption? selectedSort;
  final bool isSortSheetVisible;

  const CategoriesState({
    this.isLoading = false,
    this.categories = const [],
    this.errorMessage,
    this.isProductsLoading = false,
    this.products = const [],
    this.productsErrorMessage,
    this.selectedCategoryIndex = 0,
    this.selectedSort,
    this.isSortSheetVisible = false,
  });

  CategoriesState copyWith({
    bool? isLoading,
    List<CategoryEntity>? categories,
    String? errorMessage,
    bool clearError = false,
    bool? isProductsLoading,
    List<ProductEntity>? products,
    String? productsErrorMessage,
    bool clearProductsError = false,
    int? selectedCategoryIndex,
    SortOption? selectedSort,
    bool clearSort = false,
    bool? isSortSheetVisible,
  }) {
    return CategoriesState(
      isLoading: isLoading ?? this.isLoading,
      categories: categories ?? this.categories,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      isProductsLoading: isProductsLoading ?? this.isProductsLoading,
      products: products ?? this.products,
      productsErrorMessage: clearProductsError
          ? null
          : productsErrorMessage ?? this.productsErrorMessage,
      selectedCategoryIndex:
      selectedCategoryIndex ?? this.selectedCategoryIndex,
      selectedSort: clearSort ? null : selectedSort ?? this.selectedSort,
      isSortSheetVisible: isSortSheetVisible ?? this.isSortSheetVisible,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    categories,
    errorMessage,
    isProductsLoading,
    products,
    productsErrorMessage,
    selectedCategoryIndex,
    selectedSort,
    isSortSheetVisible,
  ];
}

