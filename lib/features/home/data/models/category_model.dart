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
    return CategoryModel(
      id: json['id'].toString(),
      name: json['name'],
      image: json['image'],
      slug: json['slug'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'image': imageUrl, 'slug': slug};
  }
}
