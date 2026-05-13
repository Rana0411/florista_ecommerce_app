import 'package:florista_ecommerce_app/core/router/nav_helper.dart';
import 'package:florista_ecommerce_app/core/shared_widgets/custom_buttom_navigation_bar.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/assets_manager.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/features/home/presentation/view_model/home_view_model.dart';
import 'package:florista_ecommerce_app/features/home/presentation/widgets/home_best_seller.dart';
import 'package:florista_ecommerce_app/features/home/presentation/widgets/home_category.dart';
import 'package:florista_ecommerce_app/features/home/presentation/widgets/home_drop_down_row.dart';
import 'package:florista_ecommerce_app/features/home/presentation/widgets/home_occasion.dart';
import 'package:florista_ecommerce_app/features/home/presentation/widgets/home_search_bar.dart';
import 'package:florista_ecommerce_app/features/home/presentation/widgets/home_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.viewModel});
  final HomeViewModel viewModel;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 10,
        title: Row(
          children: [
            Image.asset(AssetsManager.flower12Px, width: 24, height: 24),

            const SizedBox(width: 6),

            Text(
              "Flowery",
              style: TextStyle(
                fontFamily: AppFonts.imfEllEnglish,
                color: AppColors.primary,
                fontSize: 20,
              ),
            ),

            const SizedBox(width: 12),

            HomeSearchBar(),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: HomeDropDownRow(viewModel: widget.viewModel),
              ),

              BlocBuilder<HomeViewModel, HomeState>(
                buildWhen: (previous, current) =>
                    previous.getAllCategoriesState !=
                    current.getAllCategoriesState,
                builder: (context, state) {
                  final categories = state.getAllCategoriesState.data;
                  return HomeSection(
                    title: 'Categories',
                    items: categories ?? [],
                    itemBuilder: (category) {
                      return HomeCategory(category: category);
                    },
                    onViewAll: () {
                      //* Navigate to categories
                    },
                  );
                },
              ),

              BlocBuilder<HomeViewModel, HomeState>(
                buildWhen: (previous, current) =>
                    previous.getAllBestSellerState !=
                    current.getAllBestSellerState,
                builder: (context, state) {
                  final bestSellers = state.getAllBestSellerState.data;
                  return HomeSection(
                    height: 200,
                    title: 'Best seller',
                    items: bestSellers ?? [],
                    itemBuilder: (bestSeller) {
                      return HomeBestSeller(bestSeller: bestSeller);
                    },
                    onViewAll: () {
                      //* Navigate to best seller
                    },
                  );
                },
              ),

              BlocBuilder<HomeViewModel, HomeState>(
                buildWhen: (previous, current) =>
                    previous.getAllOccasionsState !=
                    current.getAllOccasionsState,
                builder: (context, state) {
                  final occasions = state.getAllOccasionsState.data;
                  return HomeSection(
                    height: 200,
                    title: 'Occasion',
                    items: occasions ?? [],
                    itemBuilder: (occasion) {
                      return HomeOccasion(occasion: occasion);
                    },
                    onViewAll: () {
                      //* Navigate to occasion
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: NavHelper.getCurrentIndex(location),
        onTap: (index) => NavHelper.onItemTapped(context, index),
      ),
    );
  }
}
