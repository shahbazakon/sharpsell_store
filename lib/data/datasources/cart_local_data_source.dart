import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/cart_item_model.dart';

abstract class CartLocalDataSource {
  Future<List<CartItemModel>> getCartItems();
  Future<void> addToCart(CartItemModel item);
  Future<void> removeFromCart(int id);
  Future<void> updateCartItemQuantity(int id, int quantity);
  Future<void> clearCart();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final SharedPreferences sharedPreferences;
  final String cartKey = 'cart_items';

  CartLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<CartItemModel>> getCartItems() async {
    final cartJson = sharedPreferences.getString(cartKey);
    if (cartJson == null) {
      return [];
    }

    final List<dynamic> cartList = json.decode(cartJson);
    return cartList.map((item) => CartItemModel.fromJson(item)).toList();
  }

  @override
  Future<void> addToCart(CartItemModel item) async {
    final cartItems = await getCartItems();

    // Check if the item is already in the cart
    final existingItemIndex =
        cartItems.indexWhere((cartItem) => cartItem.productId == item.productId);

    if (existingItemIndex != -1) {
      // Update quantity if item already exists
      final existingItem = cartItems[existingItemIndex];
      cartItems[existingItemIndex] = CartItemModel(
        id: existingItem.id,
        productId: existingItem.productId,
        productTitle: existingItem.productTitle,
        price: existingItem.price,
        imageUrl: existingItem.imageUrl,
        quantity: existingItem.quantity + item.quantity,
      );
    } else {
      // Add new item
      cartItems.add(item);
    }

    await _saveCartItems(cartItems);
  }

  @override
  Future<void> removeFromCart(int id) async {
    final cartItems = await getCartItems();
    cartItems.removeWhere((item) => item.id == id);
    await _saveCartItems(cartItems);
  }

  @override
  Future<void> updateCartItemQuantity(int id, int quantity) async {
    final cartItems = await getCartItems();
    final itemIndex = cartItems.indexWhere((item) => item.id == id);

    if (itemIndex != -1) {
      final item = cartItems[itemIndex];
      cartItems[itemIndex] = CartItemModel(
        id: item.id,
        productId: item.productId,
        productTitle: item.productTitle,
        price: item.price,
        imageUrl: item.imageUrl,
        quantity: quantity,
      );
      await _saveCartItems(cartItems);
    }
  }

  @override
  Future<void> clearCart() async {
    await sharedPreferences.remove(cartKey);
  }

  Future<void> _saveCartItems(List<CartItemModel> items) async {
    final cartJson = json.encode(items.map((item) => item.toJson()).toList());
    await sharedPreferences.setString(cartKey, cartJson);
  }
}
