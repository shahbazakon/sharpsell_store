import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/cart.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_local_data_source.dart';
import '../models/cart_item_model.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource localDataSource;

  CartRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, Cart>> getCart() async {
    try {
      final cart = await localDataSource.getCart();
      return Right(cart);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Cart>> addToCart(CartItem item) async {
    try {
      final cartItemModel = CartItemModel(
        id: item.id,
        productId: item.productId,
        name: item.name,
        price: item.price,
        imageUrl: item.imageUrl,
        quantity: item.quantity,
      );
      final updatedCart = await localDataSource.addToCart(cartItemModel);
      return Right(updatedCart);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Cart>> updateCartItem(CartItem item) async {
    try {
      final cartItemModel = CartItemModel(
        id: item.id,
        productId: item.productId,
        name: item.name,
        price: item.price,
        imageUrl: item.imageUrl,
        quantity: item.quantity,
      );
      final updatedCart = await localDataSource.updateCartItem(cartItemModel);
      return Right(updatedCart);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Cart>> removeFromCart(String itemId) async {
    try {
      final updatedCart = await localDataSource.removeFromCart(itemId);
      return Right(updatedCart);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Cart>> clearCart() async {
    try {
      final emptyCart = await localDataSource.clearCart();
      return Right(emptyCart);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }
}
