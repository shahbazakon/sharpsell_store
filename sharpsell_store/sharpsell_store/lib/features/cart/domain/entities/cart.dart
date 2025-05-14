import 'package:equatable/equatable.dart';
import 'cart_item.dart';

class Cart extends Equatable {
  final List<CartItem> items;
  final double deliveryCharge;
  final double handlingCharge;
  final double gstCharge;

  const Cart({
    required this.items,
    this.deliveryCharge = 50.0,
    this.handlingCharge = 15.0,
    this.gstCharge = 0.0,
  });

  double get subtotal => items.fold(0, (sum, item) => sum + item.totalPrice);

  double get gst => (subtotal * 0.18).roundToDouble();

  double get total => subtotal + deliveryCharge + handlingCharge + gst;

  @override
  List<Object> get props => [items, deliveryCharge, handlingCharge, gstCharge];
}
