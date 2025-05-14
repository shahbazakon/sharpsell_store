import '../../domain/entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required String id,
    required String name,
    required String imageUrl,
  }) : super(
          id: id,
          name: name,
          imageUrl: imageUrl,
        );

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
    };
  }
}
