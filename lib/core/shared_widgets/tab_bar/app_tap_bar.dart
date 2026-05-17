import 'package:florista_ecommerce_app/config/shared_models/tab_item_.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppTabBar extends StatelessWidget {
  const AppTabBar({super.key, required this.tabs, this.onTap});

  final List<TabItem> tabs;
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      onTap: onTap,
      tabAlignment: TabAlignment.start,
      isScrollable: true,
      unselectedLabelColor: AppColors.grey,
      labelColor: AppColors.primary,
      indicatorWeight: 4,
      indicator: UnderlineTabIndicator(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
        ),
        borderSide: BorderSide(color: AppColors.primary, width: 4),
      ),
      // Maps your API list to Tab widgets
      tabs: tabs.map((tabItem) => Tab(text: tabItem.name)).toList(),
    );
  }
}
