import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/constants.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getLastProducts();
  Future<void> cacheProducts(List<ProductModel> productsToCache);
  Future<ProductModel> getProductById(String id);
  Future<List<ProductModel>> getProductsByCategory(String categoryId);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProductLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<ProductModel>> getLastProducts() {
    final jsonString =
        sharedPreferences.getString(AppConstants.cachedProductsKey);
    if (jsonString != null) {
      return Future.value(
        (json.decode(jsonString) as List)
            .map((product) => ProductModel.fromJson(product))
            .toList(),
      );
    } else {
      throw CacheException(message: 'No cached products found');
    }
  }

  @override
  Future<void> cacheProducts(List<ProductModel> productsToCache) {
    return sharedPreferences.setString(
      AppConstants.cachedProductsKey,
      json.encode(productsToCache.map((product) => product.toJson()).toList()),
    );
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    final products = await getLastProducts();
    try {
      return products.firstWhere((product) => product.id == id);
    } catch (e) {
      throw CacheException(message: 'Product not found in cache');
    }
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(String categoryId) async {
    final products = await getLastProducts();
    return products
        .where((product) => product.categoryId == categoryId)
        .toList();
  }
}
