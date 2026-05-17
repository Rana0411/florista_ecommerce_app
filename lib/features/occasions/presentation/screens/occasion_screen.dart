import 'package:florista_ecommerce_app/core/shared_widgets/product_grid_view/shimmer_product_grid_view.dart';
import 'package:florista_ecommerce_app/core/shared_widgets/tab_bar/app_tap_bar.dart';
import 'package:florista_ecommerce_app/core/shared_widgets/tab_bar/shimmer_tab_bar.dart';
import 'package:florista_ecommerce_app/features/occasions/presentation/view_model/occasion_cubit.dart';
import 'package:florista_ecommerce_app/features/occasions/presentation/widgets/occasion_layout_outlines.dart';
import 'package:florista_ecommerce_app/features/occasions/presentation/widgets/occasion_porduct_body.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
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
            return OccasionView(
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(48),
                child: AppTabBarShimmer(),
              ),
              body: const ProductsGridShimmer(),
            );
          }

          if (state.occasionState.errorMessage != null) {
            return OccasionView(
              body: Center(child: Text(state.occasionState.errorMessage!)),
            );
          }

          final cubit = context.read<OccasionCubit>();
          final tabs = cubit.tabItems;

          if (tabs.isEmpty) {
            return OccasionView(
              body: Center(child: Text(S.of(context).noOccasionFounds)),
            );
          }

          return DefaultTabController(
            key: ValueKey(tabs.length),
            length: tabs.length,
            initialIndex: state.selectedTabIndex.clamp(0, tabs.length - 1),
            child: OccasionView(
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(48),
                child: AppTabBar(tabs: tabs, onTap: cubit.onTabSelected),
              ),
              body: const OccasionProductsBody(),
            ),
          );
        },
      ),
    );
  }
}
