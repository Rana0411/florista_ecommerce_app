import 'package:florista_ecommerce_app/core/shared_widgets/tab_bar/shimmer_tab_bar.dart';
import 'package:florista_ecommerce_app/core/shared_widgets/tab_bar/tab_indicator_painter.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:flutter/material.dart';

class TabItem {
  final String id;
  final String title;

  TabItem({required this.id, required this.title});
}

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({
    super.key,
    required this.fetchTabs,
    required this.onTapSelected,
  });
  final Future<List<TabItem>> Function() fetchTabs;
  final Function(TabItem) onTapSelected;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  _CustomTabBarState();

  List<TabItem> tabs = [];
  int selectedIdex = 0;
  bool isLoading = true;
  @override
  void initState() {
    loadTabs();
    super.initState();
  }

  Future<void> loadTabs() async {
    final results = await widget.fetchTabs();
    setState(() {
      tabs = results;
      isLoading = false;
    });

    if (tabs.isNotEmpty) {
      widget.onTapSelected(tabs[0]);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      CustomTabBarShimmer();
    }
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final tab = tabs[index];
          final bool isSelected = selectedIdex == index;
          return Column(
            children: [
              Text(
                tab.title,
                style: TextStyle(
                  color: isSelected ? AppColors.primary : AppColors.grey,
                  fontSize: FontSize.s16,
                  fontWeight: FontWeightManager.light,
                ),
              ),
              const SizedBox(height: 6),
              CustomPaint(
                size: const Size(45, 3),
                painter: TabIndicatorPainter(
                  color: isSelected ? AppColors.primary : AppColors.grey,
                ),
              ),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(width: 10),
        itemCount: tabs.length,
      ),
    );
  }
}
