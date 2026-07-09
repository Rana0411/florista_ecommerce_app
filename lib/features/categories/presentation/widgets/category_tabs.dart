import 'package:flutter/material.dart';

import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/features/categories/domain/entities/categories_entity.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';

class CategoryTabs extends StatelessWidget {
  final List<CategoriesEntity> categories;
  final int selectedIndex;
  final bool isLoading;
  final ValueChanged<int> onTap;

  const CategoryTabs({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final allLabel = S.of(context).all;
    final labels = isLoading
        ? [allLabel]
        : [allLabel, ...categories.map((c) => c.name)];

    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: labels.length,
        separatorBuilder: (_, __) => const SizedBox(width: 20),
        itemBuilder: (context, i) {
          final selected = selectedIndex == i;
          return GestureDetector(
            onTap: () => onTap(i),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  labels[i],
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: selected ? AppColors.primary : AppColors.hintColor,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 2,
                  width: selected ? 20 : 0,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}