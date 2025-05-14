import 'package:equatable/equatable.dart';
import '../../../domain/entities/product.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {
  final List<Product> products;
  final bool isFirstLoad;

  const ProductLoading({
    this.products = const [],
    this.isFirstLoad = true,
  });

  @override
  List<Object> get props => [products, isFirstLoad];
}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final bool hasReachedMax;

  const ProductLoaded({
    required this.products,
    this.hasReachedMax = false,
  });

  @override
  List<Object> get props => [products, hasReachedMax];
}

class ProductError extends ProductState {
  final String message;

  const ProductError({required this.message});

  @override
  List<Object> get props => [message];
}
