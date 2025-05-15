import 'product_model.dart';

class CartItemModel {
  final int id;
  final int productId;
  final String productTitle;
  final double price;
  final String imageUrl;
  final int quantity;

  CartItemModel({
    required this.id,
    required this.productId,
    required this.productTitle,
    required this.price,
    required this.imageUrl,
    required this.quantity,
  });

  double get totalPrice => price * quantity;

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'],
      productId: json['product_id'],
      productTitle: json['product_title'],
      price: json['price'].toDouble(),
      imageUrl: json['image_url'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'product_title': productTitle,
      'price': price,
      'image_url': imageUrl,
      'quantity': quantity,
    };
  }

  factory CartItemModel.fromProduct(ProductModel product, {int quantity = 1}) {
    return CartItemModel(
      id: DateTime.now().millisecondsSinceEpoch,
      productId: product.id,
      productTitle: product.title,
      price: product.price,
      imageUrl: product.mainImage,
      quantity: quantity,
    );
  }
}
