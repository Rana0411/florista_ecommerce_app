import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:florista_ecommerce_app/core/router/nav_helper.dart';
import 'package:florista_ecommerce_app/core/shared_widgets/custom_buttom_navigation_bar.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';

import '../cubit/categories_state.dart';
import '../cubit/categories_view_model.dart';
import '../widgets/product_card.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  @override
  void initState() {
    super.initState();
    context.read<CategoriesCubit>().getCategories();
  }

  @override
  Widget build(BuildContext context) {

    final String location = GoRouterState.of(context).uri.toString();

    return BlocBuilder<CategoriesCubit, CategoriesState>(

      builder: (context, state) {

        return Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Search bar ───────────────────────────────────────
                    _SearchBar(
                      onFilterTap: () =>
                          context.read<CategoriesCubit>().showSortSheet(),
                    ),

                    // ── Category tabs ────────────────────────────────────
                    _CategoryTabs(
                      categories: state.categories,
                      selectedIndex: state.selectedCategoryIndex,
                      isLoading: state.isLoading,
                      onTap: (i) =>
                          context.read<CategoriesCubit>().selectCategory(i),
                    ),

                    const SizedBox(height: 8),

                    // ── Products grid ────────────────────────────────────
                    Expanded(
                      child: state.isProductsLoading
                          ? const Center(child: CircularProgressIndicator())
                          : state.productsErrorMessage != null
                          ? _ErrorWidget(message: state.productsErrorMessage!)
                          : _ProductsGrid(products: state.products),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: CustomBottomNavigationBar(
                currentIndex: NavHelper.getCurrentIndex(location),
                onTap: (index) => NavHelper.onItemTapped(context, index),
              ),
              // ── Floating Filter button ──────────────────────────────
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () =>
                    context.read<CategoriesCubit>().showSortSheet(),
                backgroundColor: AppColors.primary,
                shape: const StadiumBorder(),
                icon: const Icon(Icons.tune, color: Colors.white, size: 20),
                label: const Text(
                  'Filter',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            ),

            // ── Sort bottom sheet overlay ──────────────────────────────
            if (state.isSortSheetVisible)
              _SortSheet(
                selectedSort: state.selectedSort,
                onClose: () => context.read<CategoriesCubit>().hideSortSheet(),
                onApply: (sort) =>
                    context.read<CategoriesCubit>().applySort(sort),
              ),
          ],
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Search Bar
// ─────────────────────────────────────────────────────────────────────────────

class _SearchBar extends StatelessWidget {
  final VoidCallback onFilterTap;

  const _SearchBar({required this.onFilterTap});

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
                color: AppColors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: TextField(
                onChanged: (q) =>
                    context.read<CategoriesCubit>().searchProducts(q),
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: AppColors.hintColor,
                    fontSize: 15,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.hintColor,
                    size: 22,
                  ),
                  border: InputBorder.none,
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
                border: Border.all(color: AppColors.hintColor),
                color: AppColors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(Icons.filter_list, color: AppColors.hintColor),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Category Tabs
// ─────────────────────────────────────────────────────────────────────────────

class _CategoryTabs extends StatelessWidget {
  final List<dynamic> categories;
  final int selectedIndex;
  final bool isLoading;
  final ValueChanged<int> onTap;

  const _CategoryTabs({
    required this.categories,
    required this.selectedIndex,
    required this.isLoading,
    required this.onTap,
  });

  static const _allLabel = 'All';

  @override
  Widget build(BuildContext context) {
    final labels = isLoading
        ? [_allLabel]
        : [_allLabel, ...categories.map((c) => c.name as String)];

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
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                    color: selected
                        ? AppColors.primary
                        : const Color(0xFF999999),
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

// ─────────────────────────────────────────────────────────────────────────────
// Products Grid
// ─────────────────────────────────────────────────────────────────────────────

class _ProductsGrid extends StatelessWidget {
  final List<ProductEntity> products;

  const _ProductsGrid({required this.products});

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(child: Text('No products found'));
    }

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.70,
      ),
      itemCount: products.length,
      itemBuilder: (context, i) => ProductCard(product: products[i]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Sort Bottom Sheet
// ─────────────────────────────────────────────────────────────────────────────

class _SortSheet extends StatefulWidget {
  final SortOption? selectedSort;
  final VoidCallback onClose;
  final ValueChanged<SortOption> onApply;

  const _SortSheet({
    required this.selectedSort,
    required this.onClose,
    required this.onApply,
  });

  @override
  State<_SortSheet> createState() => _SortSheetState();
}

class _SortSheetState extends State<_SortSheet>
    with SingleTickerProviderStateMixin {
  late SortOption? _selected;
  late AnimationController _ctrl;
  late Animation<double> _slide;

  static const _options = [
    (SortOption.lowestPrice, 'Lowest Price'),
    (SortOption.highestPrice, 'Highest Price'),
    (SortOption.newest, 'New'),
    (SortOption.oldest, 'Old'),
    (SortOption.discount, 'Discount'),
  ];

  @override
  void initState() {
    super.initState();
    _selected = widget.selectedSort;
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
    _slide = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _dismiss() {
    _ctrl.reverse().then((_) => widget.onClose());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _dismiss,
      child: Container(
        color: Colors.black.withOpacity(0.35),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: () {},
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(_slide),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Drag handle
                    Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0E0E0),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),

                    // Title
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Sort by',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Options
                    ..._options.map((opt) {
                      final isSelected = _selected == opt.$1;
                      return GestureDetector(
                        onTap: () => setState(() => _selected = opt.$1),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primary
                                  : const Color(0xFFF0F0F0),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  opt.$2,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                    color: AppColors.black,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                              Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.primary
                                        : const Color(0xFFCCCCCC),
                                    width: 2,
                                  ),
                                ),
                                child: isSelected
                                    ? Center(
                                        child: Container(
                                          width: 12,
                                          height: 12,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      )
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 8),

                    // Apply button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                        onPressed: _selected == null
                            ? null
                            : () => widget.onApply(_selected!),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        icon: const Icon(
                          Icons.tune,
                          color: Colors.white,
                          size: 18,
                        ),
                        label: const Text(
                          'Filter',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Error Widget
// ─────────────────────────────────────────────────────────────────────────────

class _ErrorWidget extends StatelessWidget {
  final String message;

  const _ErrorWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: AppColors.error),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.read<CategoriesCubit>().getCategories(),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
