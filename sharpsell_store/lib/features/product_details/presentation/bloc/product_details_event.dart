import 'package:equatable/equatable.dart';

abstract class ProductDetailsEvent extends Equatable {
  const ProductDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetProductDetailsEvent extends ProductDetailsEvent {
  final String productId;

  const GetProductDetailsEvent(this.productId);

  @override
  List<Object> get props => [productId];
}

class GetSimilarProductsEvent extends ProductDetailsEvent {
  final String productId;

  const GetSimilarProductsEvent(this.productId);

  @override
  List<Object> get props => [productId];
}
