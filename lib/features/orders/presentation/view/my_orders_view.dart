import 'package:florista_ecommerce_app/config/di/di.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/orders_cubit.dart';
import '../cubit/orders_state.dart';
import '../widgets/active_order_card.dart';
import '../widgets/completed_order_card.dart';
import '../widgets/empty_orders_widget.dart';

class MyOrdersView extends StatelessWidget {
  const MyOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<OrdersCubit>()..loadOrders(),
      child: const _MyOrdersBody(),
    );
  }
}

class _MyOrdersBody extends StatefulWidget {
  const _MyOrdersBody();

  @override
  State<_MyOrdersBody> createState() => _MyOrdersBodyState();
}

class _MyOrdersBodyState extends State<_MyOrdersBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'My orders',
          style: TextStyle(
            fontFamily: AppFonts.interFamily,
            fontSize: FontSize.s18,
            fontWeight: FontWeightManager.bold,
            color: AppColors.black,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.grey,
          labelStyle: TextStyle(
            fontFamily: AppFonts.interFamily,
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.semiBold,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: AppFonts.interFamily,
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.regular,
          ),
          indicatorColor: AppColors.primary,
          indicatorWeight: 2.5,
          tabs: const [
            Tab(text: 'Active'),
            Tab(text: 'Completed'),
          ],
        ),
      ),
      body: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state.errorMessage != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline,
                        color: AppColors.error, size: 48),
                    const SizedBox(height: 16),
                    Text(
                      state.errorMessage!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.grey,
                          fontFamily: AppFonts.interFamily),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<OrdersCubit>().loadOrders(),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary),
                      child: const Text('Retry',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            );
          }

          return TabBarView(
            controller: _tabController,
            children: [
              // ── Active Tab ─────────────────────────────────────────────
              state.activeOrders.isEmpty
                  ? const EmptyOrdersWidget(message: 'No active orders')
                  : RefreshIndicator(
                      color: AppColors.primary,
                      onRefresh: () =>
                          context.read<OrdersCubit>().loadOrders(),
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: state.activeOrders.length,
                        itemBuilder: (context, index) {
                          final order = state.activeOrders[index];
                          return ActiveOrderCard(
                            order: order,
                            onTrackOrder: () =>
                                _showTrackOrderBottomSheet(context, order.id),
                          );
                        },
                      ),
                    ),

              // ── Completed Tab ──────────────────────────────────────────
              state.completedOrders.isEmpty
                  ? const EmptyOrdersWidget(message: 'No completed orders')
                  : RefreshIndicator(
                      color: AppColors.primary,
                      onRefresh: () =>
                          context.read<OrdersCubit>().loadOrders(),
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: state.completedOrders.length,
                        itemBuilder: (context, index) {
                          final order = state.completedOrders[index];
                          return CompletedOrderCard(
                            order: order,
                            onReorder: () =>
                                _handleReorder(context, order),
                          );
                        },
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }

  void _showTrackOrderBottomSheet(BuildContext context, String orderId) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Track Order',
              style: TextStyle(
                fontFamily: AppFonts.interFamily,
                fontSize: FontSize.s18,
                fontWeight: FontWeightManager.bold,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 24),
            _TrackStep(
              icon: Icons.check_circle,
              label: 'Order Placed',
              isActive: true,
              isCompleted: true,
            ),
            _TrackStep(
              icon: Icons.inventory_2_outlined,
              label: 'Being Prepared',
              isActive: true,
              isCompleted: false,
            ),
            _TrackStep(
              icon: Icons.local_shipping_outlined,
              label: 'On the Way',
              isActive: false,
              isCompleted: false,
            ),
            _TrackStep(
              icon: Icons.home_outlined,
              label: 'Delivered',
              isActive: false,
              isCompleted: false,
              isLast: true,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _handleReorder(BuildContext context, dynamic order) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Added to cart!'),
        backgroundColor: AppColors.primary,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class _TrackStep extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final bool isCompleted;
  final bool isLast;

  const _TrackStep({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.isCompleted,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isCompleted || isActive
        ? AppColors.primary
        : AppColors.lightGrey;

    return Row(
      children: [
        Column(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted
                    ? AppColors.primary
                    : isActive
                        ? AppColors.primary.withOpacity(0.15)
                        : Colors.grey[200],
              ),
              child: Icon(
                icon,
                size: 18,
                color: isCompleted
                    ? Colors.white
                    : isActive
                        ? AppColors.primary
                        : AppColors.lightGrey,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 28,
                color: isCompleted ? AppColors.primary : Colors.grey[300],
              ),
          ],
        ),
        const SizedBox(width: 16),
        Text(
          label,
          style: TextStyle(
            fontFamily: AppFonts.interFamily,
            fontSize: FontSize.s14,
            fontWeight: isActive || isCompleted
                ? FontWeightManager.semiBold
                : FontWeightManager.regular,
            color: color,
          ),
        ),
      ],
    );
  }
}
