import '../../data/models/cart_item_model.dart';

abstract class CartRepository {
  Future<List<CartItemModel>> getCartItems();
  Future<void> addToCart(CartItemModel item);
  Future<void> removeFromCart(int id);
  Future<void> updateCartItemQuantity(int id, int quantity);
  Future<void> clearCart();
}
