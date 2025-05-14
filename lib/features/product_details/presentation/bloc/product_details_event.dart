import 'package:equatable/equatable.dart';

abstract class ProductDetailsEvent extends Equatable {
  const ProductDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetProductDetailsEvent extends ProductDetailsEvent {
  final String productId;

  const GetProductDetailsEvent({required this.productId});

  @override
  List<Object> get props => [productId];
}

class GetSimilarProductsEvent extends ProductDetailsEvent {
  final String productId;

  const GetSimilarProductsEvent({required this.productId});

  @override
  List<Object> get props => [productId];
}
