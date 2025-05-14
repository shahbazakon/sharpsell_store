import 'dart:convert';
import 'dart:developer' as developer;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/constants.dart';
import '../models/cart_item_model.dart';

abstract class CartLocalDataSource {
  Future<List<CartItemModel>> getCartItems();
  Future<List<CartItemModel>> addToCart(CartItemModel item);
  Future<List<CartItemModel>> removeFromCart(String id);
  Future<List<CartItemModel>> clearCart();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final SharedPreferences sharedPreferences;

  CartLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<CartItemModel>> getCartItems() async {
    try {
      final jsonString =
          sharedPreferences.getString(AppConstants.cachedCartKey);
      if (jsonString != null) {
        final List<dynamic> jsonList = json.decode(jsonString);
        return jsonList.map((item) => CartItemModel.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      developer.log('Error getting cart items: $e');
      throw CacheException(message: 'Failed to get cart items from cache');
    }
  }

  @override
  Future<List<CartItemModel>> addToCart(CartItemModel item) async {
    try {
      final currentCart = await getCartItems();

      // Check if item already exists in cart
      final existingItemIndex = currentCart.indexWhere(
        (cartItem) => cartItem.productId == item.productId,
      );

      if (existingItemIndex >= 0) {
        // Update quantity of existing item
        final existingItem = currentCart[existingItemIndex];
        final updatedItem = CartItemModel(
          id: existingItem.id,
          productId: existingItem.productId,
          name: existingItem.name,
          price: existingItem.price,
          quantity: existingItem.quantity + item.quantity,
          imageUrl: existingItem.imageUrl,
        );
        currentCart[existingItemIndex] = updatedItem;
      } else {
        // Add new item to cart
        currentCart.add(item);
      }

      // Save updated cart to SharedPreferences
      await _saveCartToPrefs(currentCart);

      return currentCart;
    } catch (e) {
      developer.log('Error adding item to cart: $e');
      throw CacheException(message: 'Failed to add item to cart');
    }
  }

  @override
  Future<List<CartItemModel>> removeFromCart(String id) async {
    try {
      final currentCart = await getCartItems();
      final updatedCart = currentCart.where((item) => item.id != id).toList();

      // Save updated cart to SharedPreferences
      await _saveCartToPrefs(updatedCart);

      return updatedCart;
    } catch (e) {
      developer.log('Error removing item from cart: $e');
      throw CacheException(message: 'Failed to remove item from cart');
    }
  }

  @override
  Future<List<CartItemModel>> clearCart() async {
    try {
      await sharedPreferences.remove(AppConstants.cachedCartKey);
      return [];
    } catch (e) {
      developer.log('Error clearing cart: $e');
      throw CacheException(message: 'Failed to clear cart');
    }
  }

  // Helper method to save cart to SharedPreferences
  Future<void> _saveCartToPrefs(List<CartItemModel> cart) async {
    final jsonList = cart.map((item) => item.toJson()).toList();
    final jsonString = json.encode(jsonList);
    await sharedPreferences.setString(AppConstants.cachedCartKey, jsonString);
  }
}
