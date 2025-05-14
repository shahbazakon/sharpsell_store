import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/constants.dart';
import '../models/cart_item_model.dart';
import '../models/cart_model.dart';

abstract class CartLocalDataSource {
  Future<CartModel> getCart();
  Future<CartModel> addToCart(CartItemModel item);
  Future<CartModel> updateCartItem(CartItemModel item);
  Future<CartModel> removeFromCart(String itemId);
  Future<CartModel> clearCart();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final SharedPreferences sharedPreferences;

  CartLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<CartModel> getCart() async {
    final jsonString = sharedPreferences.getString(AppConstants.cachedCartKey);
    if (jsonString != null) {
      return CartModel.fromJson(json.decode(jsonString));
    } else {
      // Return an empty cart if none exists
      return const CartModel(items: []);
    }
  }

  Future<void> _saveCart(CartModel cart) {
    return sharedPreferences.setString(
      AppConstants.cachedCartKey,
      json.encode(cart.toJson()),
    );
  }

  @override
  Future<CartModel> addToCart(CartItemModel item) async {
    try {
      final cart = await getCart();

      // Check if the item already exists in the cart
      final existingItemIndex =
          cart.items.indexWhere((i) => i.productId == item.productId);

      List<CartItemModel> updatedItems = List<CartItemModel>.from(cart.items);

      if (existingItemIndex >= 0) {
        // Update quantity if item already exists
        final existingItem = cart.items[existingItemIndex] as CartItemModel;
        final updatedItem = CartItemModel(
          id: existingItem.id,
          productId: existingItem.productId,
          name: existingItem.name,
          price: existingItem.price,
          imageUrl: existingItem.imageUrl,
          quantity: existingItem.quantity + item.quantity,
        );
        updatedItems[existingItemIndex] = updatedItem;
      } else {
        // Add new item
        updatedItems.add(item);
      }

      final updatedCart = CartModel(
        items: updatedItems,
        deliveryCharge: cart.deliveryCharge,
        handlingCharge: cart.handlingCharge,
        gstCharge: cart.gstCharge,
      );

      await _saveCart(updatedCart);
      return updatedCart;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<CartModel> updateCartItem(CartItemModel item) async {
    try {
      final cart = await getCart();

      final itemIndex = cart.items.indexWhere((i) => i.id == item.id);

      if (itemIndex < 0) {
        throw CacheException(message: 'Item not found in cart');
      }

      List<CartItemModel> updatedItems = List<CartItemModel>.from(cart.items);
      updatedItems[itemIndex] = item;

      final updatedCart = CartModel(
        items: updatedItems,
        deliveryCharge: cart.deliveryCharge,
        handlingCharge: cart.handlingCharge,
        gstCharge: cart.gstCharge,
      );

      await _saveCart(updatedCart);
      return updatedCart;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<CartModel> removeFromCart(String itemId) async {
    try {
      final cart = await getCart();

      final updatedItems = cart.items
          .where((item) => item.id != itemId)
          .map((item) => item as CartItemModel)
          .toList();

      final updatedCart = CartModel(
        items: updatedItems,
        deliveryCharge: cart.deliveryCharge,
        handlingCharge: cart.handlingCharge,
        gstCharge: cart.gstCharge,
      );

      await _saveCart(updatedCart);
      return updatedCart;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<CartModel> clearCart() async {
    try {
      const emptyCart = CartModel(items: []);
      await _saveCart(emptyCart);
      return emptyCart;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}
