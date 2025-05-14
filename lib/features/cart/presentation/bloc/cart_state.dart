import 'package:equatable/equatable.dart';
import '../../domain/entities/cart_item.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItem> items;
  final double totalPrice;

  const CartLoaded({
    required this.items,
    required this.totalPrice,
  });

  @override
  List<Object> get props => [items, totalPrice];
}

class CartError extends CartState {
  final String message;

  const CartError({required this.message});

  @override
  List<Object> get props => [message];
}
