import 'dart:developer' as developer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/usecases/add_to_cart.dart';
import '../../domain/usecases/get_cart.dart';
import '../../domain/usecases/remove_from_cart.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCart getCart;
  final AddToCart addToCart;
  final RemoveFromCart removeFromCart;
  final uuid = const Uuid();

  CartBloc({
    required this.getCart,
    required this.addToCart,
    required this.removeFromCart,
  }) : super(CartInitial()) {
    on<GetCartEvent>(_onGetCart);
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
  }

  Future<void> _onGetCart(GetCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());

    final result = await getCart();

    result.fold(
      (failure) {
        developer.log('Failed to get cart: ${failure.message}');
        emit(CartError(message: failure.message));
      },
      (items) {
        final totalPrice = _calculateTotalPrice(items);
        emit(CartLoaded(items: items, totalPrice: totalPrice));
      },
    );
  }

  Future<void> _onAddToCart(
      AddToCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());

    // Generate a unique ID for the cart item if it doesn't have one
    final item = event.item.id.isEmpty
        ? CartItem(
            id: uuid.v4(),
            productId: event.item.productId,
            name: event.item.name,
            price: event.item.price,
            quantity: event.item.quantity,
            imageUrl: event.item.imageUrl,
          )
        : event.item;

    final result = await addToCart(item);

    result.fold(
      (failure) {
        developer.log('Failed to add to cart: ${failure.message}');
        emit(CartError(message: failure.message));
      },
      (items) {
        final totalPrice = _calculateTotalPrice(items);
        emit(CartLoaded(items: items, totalPrice: totalPrice));
      },
    );
  }

  Future<void> _onRemoveFromCart(
      RemoveFromCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());

    final result = await removeFromCart(event.id);

    result.fold(
      (failure) {
        developer.log('Failed to remove from cart: ${failure.message}');
        emit(CartError(message: failure.message));
      },
      (items) {
        final totalPrice = _calculateTotalPrice(items);
        emit(CartLoaded(items: items, totalPrice: totalPrice));
      },
    );
  }

  double _calculateTotalPrice(List<CartItem> items) {
    return items.fold(
      0,
      (total, item) => total + (item.price * item.quantity),
    );
  }
}
