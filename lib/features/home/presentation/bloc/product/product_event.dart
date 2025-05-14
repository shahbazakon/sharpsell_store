import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetProductsEvent extends ProductEvent {}

class LoadMoreProductsEvent extends ProductEvent {}

class GetProductsByCategoryEvent extends ProductEvent {
  final String categoryId;

  const GetProductsByCategoryEvent({required this.categoryId});

  @override
  List<Object> get props => [categoryId];
}

class LoadMoreProductsByCategoryEvent extends ProductEvent {
  final String categoryId;

  const LoadMoreProductsByCategoryEvent({required this.categoryId});

  @override
  List<Object> get props => [categoryId];
}
