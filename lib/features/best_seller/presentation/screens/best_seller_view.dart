import 'package:florista_ecommerce_app/config/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/features/categories/presentation/widgets/product_card.dart';

import '../../domain/use_cases/best_seller_use_cases.dart';
import '../view_model/best_seller_state.dart';
import '../view_model/best_seller_view_model.dart';

class BestSellerView extends StatelessWidget {
  const BestSellerView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BestSellerViewModel(
        getBestSellerUseCase: getIt<GetBestSellerUseCase>(),
      )..getBestSeller(),
      child: const _BestSellerContent(),
    );
  }
}

class _BestSellerContent extends StatelessWidget {
  const _BestSellerContent();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, size: 28),
          color: AppColors.black,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Best seller',
              style: textTheme.headlineLarge,
            ),
            Text(
              'Bloom with our exquisite best sellers',
              style: textTheme.bodySmall,
            ),
          ],
        ),
        titleSpacing: 4,
      ),
      body: BlocBuilder<BestSellerViewModel, BestSellerState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null) {
            return _ErrorBody(
              message: state.errorMessage!,
              onRetry: () =>
                  context.read<BestSellerViewModel>().getBestSeller(),
            );
          }

          if (state.products.isEmpty) {
            return Center(
              child: Text('No products found', style: textTheme.bodyMedium),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 20,
              childAspectRatio: 0.70,
            ),
            itemCount: state.products.length,
            itemBuilder: (context, i) =>
                ProductCard(product: state.products[i]),
          );
        },
      ),
    );
  }
}

class _ErrorBody extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorBody({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}