import 'package:equatable/equatable.dart';

import '../../domain/entities/cart_item.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class GetCartEvent extends CartEvent {}

class AddToCartEvent extends CartEvent {
  final CartItem item;

  const AddToCartEvent(this.item);

  @override
  List<Object> get props => [item];
}

class UpdateCartItemEvent extends CartEvent {
  final CartItem item;

  const UpdateCartItemEvent(this.item);

  @override
  List<Object> get props => [item];
}

class RemoveFromCartEvent extends CartEvent {
  final String itemId;

  const RemoveFromCartEvent(this.itemId);

  @override
  List<Object> get props => [itemId];
}

class ClearCartEvent extends CartEvent {}
