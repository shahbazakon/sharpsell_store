import 'dart:convert';
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
      final data = await apiService.getCategories();
      return data
          .map<CategoryModel>((json) => CategoryModel.fromJson(json))
          .toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<CategoryModel>> searchCategories(String query) async {
    try {
      // API doesn't have a search endpoint, so we'll get all categories and filter them
      final categories = await getCategories();
      return categories
          .where((category) =>
              category.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
