import 'package:equatable/equatable.dart';
import 'package:florista_ecommerce_app/features/categories/domain/entities/product_entity.dart';

class BestSellerState extends Equatable {
  final List<ProductEntity> products;
  final bool isLoading;
  final String? errorMessage;

  const BestSellerState({
    this.products = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  BestSellerState copyWith({
    List<ProductEntity>? products,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return BestSellerState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [products, isLoading, errorMessage];
}