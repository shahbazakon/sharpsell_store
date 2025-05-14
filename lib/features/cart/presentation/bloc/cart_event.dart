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

class RemoveFromCartEvent extends CartEvent {
  final String id;

  const RemoveFromCartEvent(this.id);

  @override
  List<Object> get props => [id];
}

class UpdateCartItemQuantityEvent extends CartEvent {
  final String id;
  final int quantity;

  const UpdateCartItemQuantityEvent(this.id, this.quantity);

  @override
  List<Object> get props => [id, quantity];
}

class ClearCartEvent extends CartEvent {}
