import 'dart:developer' as developer;
import '../../domain/entities/product.dart';
import 'category_model.dart';

class ProductModel extends Product {
  const ProductModel({
    required String id,
    required String name,
    required String description,
    required double price,
    required List<String> images,
    required String imageUrl,
    required String categoryId,
    required String categoryName,
    required String slug,
  }) : super(
         id: id,
         name: name,
         description: description,
         price: price,
         imageUrl: imageUrl,
         images: images,
         categoryId: categoryId,
         categoryName: categoryName,
         slug: slug,
       );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    try {
      // Extract images
      List<String> imagesList = [];
      if (json['images'] != null) {
        imagesList = List<String>.from(json['images']);
      }

      // Extract category data
      String categoryId = '';
      String categoryName = '';
      if (json['category'] != null &&
          json['category'] is Map<String, dynamic>) {
        final categoryJson = json['category'] as Map<String, dynamic>;
        categoryId = categoryJson['id']?.toString() ?? '';
        categoryName = categoryJson['name']?.toString() ?? '';
      }

      return ProductModel(
        id: json['id']?.toString() ?? '',
        name: json['title']?.toString() ?? '',
        description: json['description']?.toString() ?? '',
        price:
            (json['price'] != null) ? (json['price'] as num).toDouble() : 0.0,
        images: imagesList,
        imageUrl:
            imagesList.isNotEmpty
                ? imagesList[0]
                : 'https://via.placeholder.com/400',
        categoryId: categoryId,
        categoryName: categoryName,
        slug: json['slug']?.toString() ?? '',
      );
    } catch (e) {
      developer.log('Error parsing product: $e');
      developer.log('JSON data: $json');

      // Return a fallback product model with minimal data
      return ProductModel(
        id: json['id']?.toString() ?? 'unknown',
        name: json['title']?.toString() ?? 'Unknown Product',
        description: 'No description available',
        price: 0.0,
        images: const [],
        imageUrl: 'https://via.placeholder.com/400',
        categoryId: '',
        categoryName: '',
        slug: '',
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': name,
      'description': description,
      'price': price,
      'images': images,
      'slug': slug,
      'category': {'id': categoryId, 'name': categoryName},
    };
  }
}
