import 'package:equatable/equatable.dart';
import '../../../home/domain/entities/product.dart';

class ProductDetails extends Equatable {
  final Product product;
  final List<Product> similarProducts;

  const ProductDetails({
    required this.product,
    this.similarProducts = const [],
  });

  @override
  List<Object> get props => [product, similarProducts];
}
