import 'dart:convert';
import 'dart:developer' as developer;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/constants.dart';
import '../models/category_model.dart';

abstract class CategoryLocalDataSource {
  Future<List<CategoryModel>> getLastCategories();
  Future<void> cacheCategories(List<CategoryModel> categories);
}

class CategoryLocalDataSourceImpl implements CategoryLocalDataSource {
  final SharedPreferences sharedPreferences;

  CategoryLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<CategoryModel>> getLastCategories() async {
    try {
      final jsonString =
          sharedPreferences.getString(AppConstants.cachedCategoriesKey);
      if (jsonString != null) {
        final List<dynamic> jsonList = json.decode(jsonString);
        return jsonList.map((item) => CategoryModel.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      developer.log('Error getting cached categories: $e');
      throw CacheException(message: 'Failed to get cached categories');
    }
  }

  @override
  Future<void> cacheCategories(List<CategoryModel> categories) async {
    try {
      final jsonList = categories.map((category) => category.toJson()).toList();
      final jsonString = json.encode(jsonList);
      await sharedPreferences.setString(
        AppConstants.cachedCategoriesKey,
        jsonString,
      );
    } catch (e) {
      developer.log('Error caching categories: $e');
      throw CacheException(message: 'Failed to cache categories');
    }
  }
}
