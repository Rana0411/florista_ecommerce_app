import 'package:florista_ecommerce_app/features/home/domain/entities/category_entity.dart';
import 'package:florista_ecommerce_app/features/home/presentation/widgets/home_category.dart';
import 'package:flutter/material.dart';

class HomeCategoriesList extends StatelessWidget {
  final List<CategoryEntity> categories;

  const HomeCategoriesList({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,

        itemBuilder: (context, index) {
          final category = categories[index];

          return HomeCategory(
            categoryName: category.name ?? '',
            imageUrl: category.image ?? '',
          );
        },
      ),
    );
  }
}
