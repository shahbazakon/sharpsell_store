import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/cart.dart';
import '../../domain/usecases/add_to_cart.dart';
import '../../domain/usecases/get_cart.dart';
import '../../domain/usecases/remove_from_cart.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCart getCart;
  final AddToCart addToCart;
  final RemoveFromCart removeFromCart;

  CartBloc({
    required this.getCart,
    required this.addToCart,
    required this.removeFromCart,
  }) : super(CartInitial()) {
    on<GetCartEvent>(_onGetCart);
    on<AddToCartEvent>(_onAddToCart);
    on<UpdateCartItemEvent>(_onUpdateCartItem);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<ClearCartEvent>(_onClearCart);
  }

  Future<void> _onGetCart(
    GetCartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    final result = await getCart();
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (cart) => emit(CartLoaded(cart)),
    );
  }

  Future<void> _onAddToCart(
    AddToCartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    final result = await addToCart(AddToCartParams(item: event.item));
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (cart) => emit(CartLoaded(cart)),
    );
  }

  Future<void> _onUpdateCartItem(
    UpdateCartItemEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    final result = await addToCart(AddToCartParams(item: event.item));
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (cart) => emit(CartLoaded(cart)),
    );
  }

  Future<void> _onRemoveFromCart(
    RemoveFromCartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    final result =
        await removeFromCart(RemoveFromCartParams(itemId: event.itemId));
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (cart) => emit(CartLoaded(cart)),
    );
  }

  Future<void> _onClearCart(
    ClearCartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    // In a real app, we would call a clearCart use case
    // For now, we'll just emit an empty cart
    emit(CartLoaded(Cart(items: [])));
  }
}
