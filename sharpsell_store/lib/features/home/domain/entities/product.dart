import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String categoryId;
  final String categoryName;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  List<Object> get props => [
        id,
        name,
        description,
        price,
        imageUrl,
        categoryId,
        categoryName,
      ];
}
