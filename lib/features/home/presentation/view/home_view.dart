import 'package:florista_ecommerce_app/core/router/nav_helper.dart';
import 'package:florista_ecommerce_app/core/shared_widgets/custom_buttom_navigation_bar.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/assets_manager.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
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

            SizedBox(
              width: 270,
              height: 36,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 35,
                    minHeight: 35,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 25,
                    color: AppColors.lightGrey,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.lightGrey),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: const Center(child: Text("Home View")),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: NavHelper.getCurrentIndex(location),
        onTap: (index) => NavHelper.onItemTapped(context, index),
      ),
    );
  }
}
