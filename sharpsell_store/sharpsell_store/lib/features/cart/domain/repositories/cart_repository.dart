import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/cart.dart';
import '../entities/cart_item.dart';

abstract class CartRepository {
  Future<Either<Failure, Cart>> getCart();
  Future<Either<Failure, Cart>> addToCart(CartItem item);
  Future<Either<Failure, Cart>> updateCartItem(CartItem item);
  Future<Either<Failure, Cart>> removeFromCart(String itemId);
  Future<Either<Failure, Cart>> clearCart();
}
