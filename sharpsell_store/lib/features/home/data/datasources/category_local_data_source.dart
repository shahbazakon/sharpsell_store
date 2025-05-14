import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/constants.dart';
import '../models/category_model.dart';

abstract class CategoryLocalDataSource {
  Future<List<CategoryModel>> getLastCategories();
  Future<void> cacheCategories(List<CategoryModel> categoriesToCache);
}

class CategoryLocalDataSourceImpl implements CategoryLocalDataSource {
  final SharedPreferences sharedPreferences;

  CategoryLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<CategoryModel>> getLastCategories() {
    final jsonString =
        sharedPreferences.getString(AppConstants.cachedCategoriesKey);
    if (jsonString != null) {
      return Future.value(
        (json.decode(jsonString) as List)
            .map((category) => CategoryModel.fromJson(category))
            .toList(),
      );
    } else {
      throw CacheException(message: 'No cached categories found');
    }
  }

  @override
  Future<void> cacheCategories(List<CategoryModel> categoriesToCache) {
    return sharedPreferences.setString(
      AppConstants.cachedCategoriesKey,
      json.encode(
          categoriesToCache.map((category) => category.toJson()).toList()),
    );
  }
}
