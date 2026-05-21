import 'package:florista_ecommerce_app/config/di/di.dart';
import 'package:florista_ecommerce_app/features/categories/domain/use_cases/categories_use_cases.dart';
import 'package:florista_ecommerce_app/features/categories/domain/use_cases/get_products_by_category_use_case.dart';
import 'package:florista_ecommerce_app/features/categories/presentation/cubit/categories_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:florista_ecommerce_app/core/router/nav_helper.dart';
import 'package:florista_ecommerce_app/core/shared_widgets/custom_buttom_navigation_bar.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';

import '../cubit/categories_state.dart';
import '../widgets/categories_search_bar.dart';
import '../widgets/category_tabs.dart';
import '../widgets/products_grid.dart';
import '../widgets/sort_sheet.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CategoriesCubit(
        getCategoriesUseCase: getIt<GetCategoriesUseCase>(),
        getProductsByCategoryUseCase: getIt<GetProductsByCategoryUseCase>(),
      )..getCategories(),
      child: const _CategoriesContent(),
    );
  }
}

class _CategoriesContent extends StatelessWidget {
  const _CategoriesContent();

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: AppColors.white,
              body: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CategoriesSearchBar(
                      onFilterTap: () =>
                          context.read<CategoriesCubit>().showSortSheet(),
                    ),
                    CategoryTabs(
                      categories: state.categories,
                      selectedIndex: state.selectedCategoryIndex,
                      isLoading: state.isLoading,
                      onTap: (i) =>
                          context.read<CategoriesCubit>().selectCategory(i),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: state.isProductsLoading
                          ? const Center(child: CircularProgressIndicator())
                          : state.productsErrorMessage != null
                          ? ProductsErrorWidget(
                          message: state.productsErrorMessage!)
                          : ProductsGrid(products: state.products),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: CustomBottomNavigationBar(
                currentIndex: NavHelper.getCurrentIndex(location),
                onTap: (index) => NavHelper.onItemTapped(context, index),
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () =>
                    context.read<CategoriesCubit>().showSortSheet(),
                backgroundColor: AppColors.primary,
                shape: const StadiumBorder(),
                icon: const Icon(Icons.tune, color: Colors.white, size: 20),
                label: Text(
                  'Filter',
                  style: textTheme.titleSmall?.copyWith(color: AppColors.white),
                ),
              ),
              floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
            ),
            if (state.isSortSheetVisible)
              SortSheet(
                selectedSort: state.selectedSort,
                onClose: () =>
                    context.read<CategoriesCubit>().hideSortSheet(),
                onApply: (sort) =>
                    context.read<CategoriesCubit>().applySort(sort),
              ),
          ],
        );
      },
    );
  }
}