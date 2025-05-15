import 'package:equatable/equatable.dart';
import 'category.dart';

class Product extends Equatable {
  final int id;
  final String title;
  final String slug;
  final int price;
  final String description;
  final Category category;
  final List<String> images;
  final String creationAt;
  final String updatedAt;

  const Product({
    required this.id,
    required this.title,
    required this.slug,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
    required this.creationAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        slug,
        price,
        description,
        category,
        images,
        creationAt,
        updatedAt,
      ];
}
