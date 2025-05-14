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
}

class ProductDetailsError extends ProductDetailsState {
  final String message;

  const ProductDetailsError({required this.message});

  @override
  List<Object> get props => [message];
}
