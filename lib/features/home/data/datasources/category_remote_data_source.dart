import 'dart:developer' as developer;
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_service.dart';
import '../models/category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<List<CategoryModel>> searchCategories(String query);
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final ApiService apiService;

  CategoryRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await apiService.getCategories();
      return response.map((json) => CategoryModel.fromJson(json)).toList();
    } catch (e) {
      developer.log('Error getting categories: $e');
      throw ServerException(message: 'Failed to get categories');
    }
  }

  @override
  Future<List<CategoryModel>> searchCategories(String query) async {
    try {
      // Get all categories and filter them since the API doesn't support search
      final categories = await getCategories();
      return categories
          .where((category) =>
              category.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (e) {
      developer.log('Error searching categories: $e');
      throw ServerException(message: 'Failed to search categories');
    }
  }
}
