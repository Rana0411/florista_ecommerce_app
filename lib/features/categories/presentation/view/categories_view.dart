import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:florista_ecommerce_app/core/router/nav_helper.dart';
import 'package:florista_ecommerce_app/core/shared_widgets/custom_buttom_navigation_bar.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';

import '../cubit/categories_state.dart';
import '../cubit/categories_view_model.dart';
import '../widgets/categories_search_bar.dart';
import '../widgets/category_tabs.dart';
import '../widgets/products_grid.dart';
import '../widgets/sort_sheet.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  @override
  void initState() {
    super.initState();
    context.read<CategoriesCubit>().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.white,
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
                label: const Text(
                  'Filter',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
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