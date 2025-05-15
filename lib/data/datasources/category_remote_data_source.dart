import '../../core/network/api_client.dart';
import '../models/category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories({int limit = 10, int offset = 0});
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final ApiClient apiClient;

  CategoryRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<CategoryModel>> getCategories({int limit = 10, int offset = 0}) async {
    try {
      final response = await apiClient.get('categories?limit=$limit');
      return (response as List).map((category) => CategoryModel.fromJson(category)).toList();
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }
}
