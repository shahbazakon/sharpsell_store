import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/constants.dart';
import '../models/category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<List<CategoryModel>> searchCategories(String query);
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final Dio client;

  CategoryRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await client.get('${AppConstants.baseUrl}/categories');
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((category) => CategoryModel.fromJson(category))
            .toList();
      } else {
        throw ServerException(message: 'Failed to load categories');
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<CategoryModel>> searchCategories(String query) async {
    try {
      // Get all categories and filter them by name
      final categories = await getCategories();
      return categories
          .where(
            (category) =>
                category.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
