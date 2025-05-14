import 'dart:convert';
import '../../domain/entities/cart_item.dart';

class CartItemModel extends CartItem {
  const CartItemModel({
    required String id,
    required String productId,
    required String name,
    required double price,
    required int quantity,
    required String imageUrl,
  }) : super(
          id: id,
          productId: productId,
          name: name,
          price: price,
          quantity: quantity,
          imageUrl: imageUrl,
        );

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'],
      productId: json['productId'],
      name: json['name'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'name': name,
      'price': price,
      'quantity': quantity,
      'imageUrl': imageUrl,
    };
  }

  factory CartItemModel.fromCartItem(CartItem cartItem) {
    return CartItemModel(
      id: cartItem.id,
      productId: cartItem.productId,
      name: cartItem.name,
      price: cartItem.price,
      quantity: cartItem.quantity,
      imageUrl: cartItem.imageUrl,
    );
  }
}
