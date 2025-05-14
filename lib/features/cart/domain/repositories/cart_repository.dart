import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/cart_item.dart';

abstract class CartRepository {
  Future<Either<Failure, List<CartItem>>> getCartItems();
  Future<Either<Failure, List<CartItem>>> addToCart(CartItem item);
  Future<Either<Failure, List<CartItem>>> removeFromCart(String id);
  Future<Either<Failure, List<CartItem>>> updateCartItemQuantity(
      String id, int quantity);
  Future<Either<Failure, List<CartItem>>> clearCart();
}
