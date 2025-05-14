import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final String id;
  final String productId;
  final String name;
  final double price;
  final int quantity;
  final String imageUrl;

  const CartItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });

  CartItem copyWith({
    String? id,
    String? productId,
    String? name,
    double? price,
    int? quantity,
    String? imageUrl,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object> get props => [id, productId, name, price, quantity, imageUrl];
}
