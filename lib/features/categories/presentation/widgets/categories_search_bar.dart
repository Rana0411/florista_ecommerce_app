import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import '../cubit/categories_view_model.dart';

class CategoriesSearchBar extends StatelessWidget {
  final VoidCallback onFilterTap;

  const CategoriesSearchBar({super.key, required this.onFilterTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: AppColors.hintColor),
                borderRadius: BorderRadius.circular(14),
              ),
              child: TextField(
                onChanged: (q) =>
                    context.read<CategoriesCubit>().searchProducts(q),
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle:
                  TextStyle(color: AppColors.hintColor, fontSize: 15),
                  prefixIcon:
                  Icon(Icons.search, color: AppColors.hintColor, size: 22),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: onFilterTap,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.hintColor),
              ),
              child: Icon(Icons.filter_list, color: AppColors.hintColor),
            ),
          ),
        ],
      ),
    );
  }
}