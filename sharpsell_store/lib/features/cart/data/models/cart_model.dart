import '../../domain/entities/cart.dart';
import '../../domain/entities/cart_item.dart';
import 'cart_item_model.dart';

class CartModel extends Cart {
  const CartModel({
    required List<CartItem> items,
    double deliveryCharge = 50.0,
    double handlingCharge = 15.0,
    double gstCharge = 0.0,
  }) : super(
          items: items,
          deliveryCharge: deliveryCharge,
          handlingCharge: handlingCharge,
          gstCharge: gstCharge,
        );

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      items: (json['items'] as List)
          .map((item) => CartItemModel.fromJson(item))
          .toList(),
      deliveryCharge: json['delivery_charge'].toDouble(),
      handlingCharge: json['handling_charge'].toDouble(),
      gstCharge: json['gst_charge'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => (item as CartItemModel).toJson()).toList(),
      'delivery_charge': deliveryCharge,
      'handling_charge': handlingCharge,
      'gst_charge': gstCharge,
    };
  }
}
