import 'dart:developer' as developer;
import '../../domain/entities/category.dart';

class CategoryModel extends Category {
  final String slug;
  final String image;

  const CategoryModel({
    required String id,
    required String name,
    required this.image,
    required this.slug,
  }) : super(id: id, name: name, imageUrl: image);

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    try {
      return CategoryModel(
        id: json['id']?.toString() ?? '',
        name: json['name']?.toString() ?? '',
        image: json['image']?.toString() ?? 'https://via.placeholder.com/400',
        slug: json['slug']?.toString() ?? '',
      );
    } catch (e) {
      developer.log('Error parsing category: $e');
      developer.log('JSON data: $json');

      // Return a fallback category model
      return const CategoryModel(
        id: 'unknown',
        name: 'Unknown Category',
        image: 'https://via.placeholder.com/400',
        slug: '',
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'image': imageUrl, 'slug': slug};
  }
}
