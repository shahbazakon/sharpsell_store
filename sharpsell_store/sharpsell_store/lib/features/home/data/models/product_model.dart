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
    final List<String> imagesList = List<String>.from(json['images'] ?? []);

    final categoryJson = json['category'] as Map<String, dynamic>?;
    final String categoryId =
        categoryJson != null ? categoryJson['id'].toString() : '';
    final String categoryName =
        categoryJson != null ? categoryJson['name'] ?? '' : '';

    return ProductModel(
      id: json['id'].toString(),
      name: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      images: imagesList,
      imageUrl: imagesList.isNotEmpty
          ? imagesList[0]
          : 'https://via.placeholder.com/400',
      categoryId: categoryId,
      categoryName: categoryName,
      slug: json['slug'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': name,
      'description': description,
      'price': price,
      'images': images,
      'slug': slug,
      'category': {
        'id': categoryId,
        'name': categoryName,
      },
    };
  }
}
