import 'package:florista_ecommerce_app/core/shared_widgets/product_grid_view/products_grid_view.dart';
import 'package:florista_ecommerce_app/core/shared_widgets/product_grid_view/shimmer_product_grid_view.dart';
import 'package:florista_ecommerce_app/core/shared_widgets/tab_bar/app_tap_bar.dart';
import 'package:florista_ecommerce_app/core/shared_widgets/tab_bar/shimmer_tab_bar.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/features/occasions/presentation/view_model/occasion_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OccasionScreen extends StatefulWidget {
  const OccasionScreen({super.key, required this.occasionCubit});

  final OccasionCubit occasionCubit;

  @override
  State<OccasionScreen> createState() => _OccasionScreenState();
}

class _OccasionScreenState extends State<OccasionScreen> {
  @override
  void initState() {
    super.initState();
    widget.occasionCubit.getAllOccasions();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.occasionCubit,
      child: BlocBuilder<OccasionCubit, OccasionState>(
        builder: (context, state) {
          if (state.occasionState.isLoading == true) {
            return _buildScaffold(
              context,
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(48),
                child: AppTabBarShimmer(),
              ),
              body: const ProductsGridShimmer(),
            );
          }

          if (state.occasionState.errorMessage != null) {
            return _buildScaffold(
              context,
              body: Center(child: Text(state.occasionState.errorMessage!)),
            );
          }

          final cubit = context.read<OccasionCubit>();
          final tabs = cubit.tabItems;

          if (tabs.isEmpty) {
            return _buildScaffold(
              context,
              body: const Center(child: Text('No occasions found')),
            );
          }

          // TabBar requires a TabController ancestor.
          return DefaultTabController(
            key: ValueKey(tabs.length),
            length: tabs.length,
            initialIndex: state.selectedTabIndex.clamp(0, tabs.length - 1),
            child: _buildScaffold(
              context,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(48),
                child: AppTabBar(tabs: tabs, onTap: cubit.onTabSelected),
              ),
              body: const _OccasionProductsBody(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildScaffold(
    BuildContext context, {
    required Widget body,
    PreferredSizeWidget? bottom,
  }) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Occasions',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Bloom with our exquisite best sellers',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.lightGrey),
            ),
          ],
        ),
        bottom: bottom,
      ),
      body: body,
    );
  }
}

/// Rebuilds only when product loading/data/error changes.
class _OccasionProductsBody extends StatelessWidget {
  const _OccasionProductsBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OccasionCubit, OccasionState>(
      buildWhen: (previous, current) =>
          previous.productState != current.productState,
      builder: (context, state) {
        if (state.productState.isLoading == true) {
          return const ProductsGridShimmer();
        }

        if (state.productState.errorMessage != null) {
          return Center(child: Text(state.productState.errorMessage!));
        }

        final products = state.productState.data ?? [];

        if (products.isEmpty) {
          return const Center(child: Text('No products for this occasion'));
        }

        return ProductsGridView(products: products);
      },
    );
  }
}
