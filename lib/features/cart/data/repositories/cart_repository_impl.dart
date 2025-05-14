import 'dart:developer' as developer;
import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_local_data_source.dart';
import '../models/cart_item_model.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource localDataSource;

  CartRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<CartItem>>> getCartItems() async {
    try {
      final cartItems = await localDataSource.getCartItems();
      return Right(cartItems);
    } on CacheException catch (e) {
      developer.log('Cache exception when getting cart items: ${e.message}');
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      developer.log('Unexpected error when getting cart items: $e');
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CartItem>>> addToCart(CartItem item) async {
    try {
      final cartItemModel = CartItemModel(
        id: item.id,
        productId: item.productId,
        name: item.name,
        price: item.price,
        quantity: item.quantity,
        imageUrl: item.imageUrl,
      );

      final updatedCart = await localDataSource.addToCart(cartItemModel);
      return Right(updatedCart);
    } on CacheException catch (e) {
      developer.log('Cache exception when adding to cart: ${e.message}');
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      developer.log('Unexpected error when adding to cart: $e');
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CartItem>>> removeFromCart(String id) async {
    try {
      final updatedCart = await localDataSource.removeFromCart(id);
      return Right(updatedCart);
    } on CacheException catch (e) {
      developer.log('Cache exception when removing from cart: ${e.message}');
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      developer.log('Unexpected error when removing from cart: $e');
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CartItem>>> updateCartItemQuantity(
    String id,
    int quantity,
  ) async {
    try {
      // Get current cart
      final currentCartResult = await getCartItems();

      return currentCartResult.fold(
        (failure) => Left(failure),
        (currentCart) async {
          // Find the item to update
          final itemIndex = currentCart.indexWhere((item) => item.id == id);

          if (itemIndex == -1) {
            return Left(CacheFailure(message: 'Item not found in cart'));
          }

          // Get the item and create an updated version
          final item = currentCart[itemIndex];
          final updatedItem = CartItemModel(
            id: item.id,
            productId: item.productId,
            name: item.name,
            price: item.price,
            quantity: quantity,
            imageUrl: item.imageUrl,
          );

          // Remove the old item and add the updated one
          await localDataSource.removeFromCart(id);
          final updatedCart = await localDataSource.addToCart(updatedItem);

          return Right(updatedCart);
        },
      );
    } on CacheException catch (e) {
      developer.log('Cache exception when updating cart: ${e.message}');
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      developer.log('Unexpected error when updating cart: $e');
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CartItem>>> clearCart() async {
    try {
      final emptyCart = await localDataSource.clearCart();
      return Right(emptyCart);
    } on CacheException catch (e) {
      developer.log('Cache exception when clearing cart: ${e.message}');
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      developer.log('Unexpected error when clearing cart: $e');
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
