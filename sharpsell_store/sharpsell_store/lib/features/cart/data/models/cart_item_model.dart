import '../../domain/entities/cart_item.dart';

class CartItemModel extends CartItem {
  const CartItemModel({
    required String id,
    required String productId,
    required String name,
    required double price,
    required String imageUrl,
    required int quantity,
  }) : super(
          id: id,
          productId: productId,
          name: name,
          price: price,
          imageUrl: imageUrl,
          quantity: quantity,
        );

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'],
      productId: json['product_id'],
      name: json['name'],
      price: json['price'].toDouble(),
      imageUrl: json['image_url'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'name': name,
      'price': price,
      'image_url': imageUrl,
      'quantity': quantity,
    };
  }
}
