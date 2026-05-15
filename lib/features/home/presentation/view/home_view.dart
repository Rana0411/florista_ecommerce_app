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
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<HomeViewModel>();
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
              // DropDown Button
              Align(
                alignment: Alignment.centerLeft,
                child: HomeDropDownRow(viewModel: viewModel),
              ),

              // Categories Section
              BlocBuilder<HomeViewModel, HomeState>(
                buildWhen: (previous, current) =>
                    previous.getAllCategoriesState !=
                    current.getAllCategoriesState,
                builder: (context, state) {
                  final categoryState = state.getAllCategoriesState;

                  if (categoryState.isLoading == true) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (categoryState.errorMessage != null) {
                    return Center(
                      child: Text(
                        categoryState.errorMessage!,
                        style: TextStyle(color: AppColors.error),
                      ),
                    );
                  }

                  final categories = categoryState.data ?? [];

                  return HomeSection(
                    title: 'Categories',
                    items: categories,
                    itemBuilder: (category) {
                      return HomeCategory(category: category);
                    },
                    onViewAll: () {},
                  );
                },
              ),

              //BestSellers Section
              BlocBuilder<HomeViewModel, HomeState>(
                buildWhen: (previous, current) =>
                    previous.getAllBestSellerState !=
                    current.getAllBestSellerState,
                builder: (context, state) {
                  final bestSellerState = state.getAllBestSellerState;

                  if (bestSellerState.isLoading == true) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (bestSellerState.errorMessage != null) {
                    return Center(
                      child: Text(
                        bestSellerState.errorMessage!,
                        style: TextStyle(color: AppColors.error),
                      ),
                    );
                  }

                  final bestSellers = bestSellerState.data ?? [];

                  return HomeSection(
                    height: 200,
                    title: 'Best seller',
                    items: bestSellers,
                    itemBuilder: (bestSeller) {
                      return HomeBestSeller(bestSeller: bestSeller);
                    },
                    onViewAll: () {},
                  );
                },
              ),

              //Occasions Section
              BlocBuilder<HomeViewModel, HomeState>(
                buildWhen: (previous, current) =>
                    previous.getAllOccasionsState !=
                    current.getAllOccasionsState,
                builder: (context, state) {
                  final occasionState = state.getAllOccasionsState;

                  if (occasionState.isLoading == true) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (occasionState.errorMessage != null) {
                    return Center(
                      child: Text(
                        occasionState.errorMessage!,
                        style: TextStyle(color: AppColors.error),
                      ),
                    );
                  }

                  final occasions = occasionState.data ?? [];

                  return HomeSection(
                    height: 200,
                    title: 'Occasion',
                    items: occasions,
                    itemBuilder: (occasion) {
                      return HomeOccasion(occasion: occasion);
                    },
                    onViewAll: () {},
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
