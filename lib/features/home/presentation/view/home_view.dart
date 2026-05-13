import 'package:florista_ecommerce_app/core/router/nav_helper.dart';
import 'package:florista_ecommerce_app/core/shared_widgets/custom_buttom_navigation_bar.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/assets_manager.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/features/home/presentation/widgets/home_categories_list.dart';
import 'package:florista_ecommerce_app/features/home/presentation/widgets/home_drop_down_row.dart';
import 'package:florista_ecommerce_app/features/home/presentation/widgets/home_search_bar.dart';
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

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Categories",
                    style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight(500),
                      fontSize: 18,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //* Add Categories Navigation here
                    },
                    child: Text(
                      "View All",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight(500),
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),

              HomeCategoriesList(categories: []),
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
