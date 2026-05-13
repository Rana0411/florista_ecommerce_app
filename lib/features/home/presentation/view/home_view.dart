import 'package:florista_ecommerce_app/core/router/nav_helper.dart';
import 'package:florista_ecommerce_app/core/shared_widgets/custom_buttom_navigation_bar.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/assets_manager.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/features/home/domain/entities/best_seller_entity.dart';
import 'package:florista_ecommerce_app/features/home/domain/entities/category_entity.dart';
import 'package:florista_ecommerce_app/features/home/domain/entities/occasion_entity.dart';
import 'package:florista_ecommerce_app/features/home/presentation/widgets/home_best_seller.dart';
import 'package:florista_ecommerce_app/features/home/presentation/widgets/home_category.dart';
import 'package:florista_ecommerce_app/features/home/presentation/widgets/home_drop_down_row.dart';
import 'package:florista_ecommerce_app/features/home/presentation/widgets/home_occasion.dart';
import 'package:florista_ecommerce_app/features/home/presentation/widgets/home_search_bar.dart';
import 'package:florista_ecommerce_app/features/home/presentation/widgets/home_section.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String selectedLocation = 'Deliver to 2XVP+XC - Sheikh Zayed';
  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    final List<DropdownMenuItem<String>> items = [
      const DropdownMenuItem(
        value: 'Deliver to 2XVP+XC - Sheikh Zayed',
        child: Text('Deliver to 2XVP+XC - Sheikh Zayed'),
      ),
      const DropdownMenuItem(
        value: 'Deliver to 2XVP+XC - Ismailia',
        child: Text('Deliver to 2XVP+XC - Ismailia'),
      ),
      const DropdownMenuItem(
        value: 'Deliver to 2XVP+XC - Tanta',
        child: Text('Deliver to 2XVP+XC - Tanta'),
      ),
    ];

    final List<HomeCategory> categories = [
      HomeCategory(
        category: CategoryEntity(id: 'id', name: "Flowers", image: 'image'),
      ),
      HomeCategory(
        category: CategoryEntity(id: 'id', name: "Gift", image: 'image'),
      ),
      HomeCategory(
        category: CategoryEntity(id: 'id', name: "Card", image: 'image'),
      ),
      HomeCategory(
        category: CategoryEntity(id: 'id', name: "Jewellery", image: 'image'),
      ),
    ];

    final List<HomeBestSeller> bestSellers = [
      HomeBestSeller(
        bestSeller: BestSellerEntity(
          id: 'id',
          title: 'Sunney',
          imgCover: 'assets/icons/test.png',
          price: 600,
        ),
      ),
      HomeBestSeller(
        bestSeller: BestSellerEntity(
          id: 'id',
          title: 'Red roses',
          imgCover: 'assets/icons/test.png',
          price: 600,
        ),
      ),
      HomeBestSeller(
        bestSeller: BestSellerEntity(
          id: 'id',
          title: 'Spring Vasels',
          imgCover: 'assets/icons/test.png',
          price: 600,
        ),
      ),
    ];

    final List<HomeOccasion> occasions = [
      HomeOccasion(
        occasion: OccasionEntity(
          id: 'id',
          name: 'Wedding',
          image: 'assets/icons/test.png',
        ),
      ),
      HomeOccasion(
        occasion: OccasionEntity(
          id: 'id',
          name: 'Birthday',
          image: 'assets/icons/test.png',
        ),
      ),
      HomeOccasion(
        occasion: OccasionEntity(
          id: 'id',
          name: 'Graduation',
          image: 'assets/icons/test.png',
        ),
      ),
    ];

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
                child: HomeDropDownRow(
                  selectedLocation: selectedLocation,
                  items: items,
                ),
              ),

              HomeSection(
                title: 'Categories',
                items: categories,
                itemBuilder: (category) {
                  return HomeCategory(
                    category: CategoryEntity(
                      id: 'id',
                      name: category.category.name,
                      image: category.category.image,
                    ),
                  );
                },
                onViewAll: () {
                  //* Navigate to categories
                },
              ),

              HomeSection(
                height: 200,
                title: 'Best seller',
                items: bestSellers,
                itemBuilder: (bestSeller) {
                  return HomeBestSeller(
                    bestSeller: BestSellerEntity(
                      id: bestSeller.bestSeller.id,
                      title: bestSeller.bestSeller.title,
                      imgCover: bestSeller.bestSeller.imgCover,
                      price: bestSeller.bestSeller.price,
                    ),
                  );
                },
              ),

              HomeSection(
                height: 200,
                title: 'Occasion',
                items: occasions,
                itemBuilder: (occasion) {
                  return HomeOccasion(
                    occasion: OccasionEntity(
                      id: occasion.occasion.id,
                      name: occasion.occasion.name,
                      image: occasion.occasion.image,
                    ),
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
