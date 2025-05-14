import 'package:equatable/equatable.dart';

import '../../../home/domain/entities/product.dart';

abstract class ProductDetailsState extends Equatable {
  const ProductDetailsState();

  @override
  List<Object> get props => [];
}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class ProductDetailsLoaded extends ProductDetailsState {
  final Product product;
  final List<Product> similarProducts;

  const ProductDetailsLoaded({
    required this.product,
    this.similarProducts = const [],
  });

  @override
  List<Object> get props => [product, similarProducts];

  ProductDetailsLoaded copyWith({
    Product? product,
    List<Product>? similarProducts,
  }) {
    return ProductDetailsLoaded(
      product: product ?? this.product,
      similarProducts: similarProducts ?? this.similarProducts,
    );
  }
}

class ProductDetailsError extends ProductDetailsState {
  final String message;

  const ProductDetailsError(this.message);

  @override
  List<Object> get props => [message];
}

class SimilarProductsLoading extends ProductDetailsState {}

class SimilarProductsLoaded extends ProductDetailsState {
  final List<Product> similarProducts;

  const SimilarProductsLoaded(this.similarProducts);

  @override
  List<Object> get props => [similarProducts];
}

class SimilarProductsError extends ProductDetailsState {
  final String message;

  const SimilarProductsError(this.message);

  @override
  List<Object> get props => [message];
}
