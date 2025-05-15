import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_local_data_source.dart';
import '../models/cart_item_model.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource localDataSource;

  CartRepositoryImpl({required this.localDataSource});

  @override
  Future<List<CartItemModel>> getCartItems() async {
    try {
      return await localDataSource.getCartItems();
    } catch (e) {
      throw Exception('Failed to get cart items: $e');
    }
  }

  @override
  Future<void> addToCart(CartItemModel item) async {
    try {
      await localDataSource.addToCart(item);
    } catch (e) {
      throw Exception('Failed to add item to cart: $e');
    }
  }

  @override
  Future<void> removeFromCart(int id) async {
    try {
      await localDataSource.removeFromCart(id);
    } catch (e) {
      throw Exception('Failed to remove item from cart: $e');
    }
  }

  @override
  Future<void> updateCartItemQuantity(int id, int quantity) async {
    try {
      await localDataSource.updateCartItemQuantity(id, quantity);
    } catch (e) {
      throw Exception('Failed to update cart item quantity: $e');
    }
  }

  @override
  Future<void> clearCart() async {
    try {
      await localDataSource.clearCart();
    } catch (e) {
      throw Exception('Failed to clear cart: $e');
    }
  }
}
