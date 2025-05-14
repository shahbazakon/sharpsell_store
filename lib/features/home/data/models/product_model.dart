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
    final String firstImage = imagesList.isNotEmpty ? imagesList[0] : '';

    return ProductModel(
      id: json['id'].toString(),
      name: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      images: imagesList,
      imageUrl: firstImage,
      categoryId: json['category']?['id']?.toString() ?? '',
      categoryName: json['category']?['name'] ?? '',
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
      'category': {'id': categoryId, 'name': categoryName},
      'slug': slug,
    };
  }
}
