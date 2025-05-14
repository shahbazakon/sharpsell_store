import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name; // title in API
  final String description;
  final double price;
  final String imageUrl; // first image from images array
  final List<String> images; // all images
  final String categoryId;
  final String categoryName;
  final String slug;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.images = const [],
    required this.categoryId,
    required this.categoryName,
    this.slug = '',
  });

  @override
  List<Object> get props => [
    id,
    name,
    description,
    price,
    imageUrl,
    images,
    categoryId,
    categoryName,
    slug,
  ];
}
