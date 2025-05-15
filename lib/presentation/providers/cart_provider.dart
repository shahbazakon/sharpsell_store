import 'package:flutter/material.dart';
import '../../data/models/cart_item_model.dart';
import '../../data/models/product_model.dart';
import '../../domain/repositories/cart_repository.dart';

class CartProvider extends ChangeNotifier {
  final CartRepository cartRepository;

  CartProvider({required this.cartRepository});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<CartItemModel> _cartItems = [];
  List<CartItemModel> get cartItems => _cartItems;

  String _error = '';
  String get error => _error;

  double get totalPrice {
    return _cartItems.fold(0, (total, item) => total + item.totalPrice);
  }

  int get itemCount {
    return _cartItems.fold(0, (total, item) => total + item.quantity);
  }

  Future<void> getCartItems() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _cartItems = await cartRepository.getCartItems();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> addToCart(ProductModel product, {int quantity = 1}) async {
    try {
      final cartItem = CartItemModel.fromProduct(product, quantity: quantity);
      await cartRepository.addToCart(cartItem);
      await getCartItems(); // Refresh cart items
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> removeFromCart(int id) async {
    try {
      await cartRepository.removeFromCart(id);
      await getCartItems(); // Refresh cart items
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> updateCartItemQuantity(int id, int quantity) async {
    try {
      await cartRepository.updateCartItemQuantity(id, quantity);
      await getCartItems(); // Refresh cart items
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> clearCart() async {
    try {
      await cartRepository.clearCart();
      _cartItems = [];
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
