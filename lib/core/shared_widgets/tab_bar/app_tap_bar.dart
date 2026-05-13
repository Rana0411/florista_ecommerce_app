import 'package:florista_ecommerce_app/config/models/tab_item_.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppTabBar extends StatelessWidget {
  const AppTabBar({super.key, required this.tabs});

  final List<TabItem> tabs;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      unselectedLabelColor: AppColors.grey,
      labelColor: AppColors.primary, // The pink color
      indicatorColor: AppColors.primary,
      indicatorWeight: 3,
      // Maps your API list to Tab widgets
      tabs: tabs.map((tabItem) => Tab(text: tabItem.name)).toList(),
    );
  }
}
