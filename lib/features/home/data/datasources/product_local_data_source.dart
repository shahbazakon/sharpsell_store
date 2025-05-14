import 'dart:convert';
import 'dart:developer' as developer;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/constants.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getLastProducts();
  Future<void> cacheProducts(List<ProductModel> products);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProductLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<ProductModel>> getLastProducts() async {
    try {
      final jsonString =
          sharedPreferences.getString(AppConstants.cachedProductsKey);
      if (jsonString != null) {
        final List<dynamic> jsonList = json.decode(jsonString);
        return jsonList.map((item) => ProductModel.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      developer.log('Error getting cached products: $e');
      throw CacheException(message: 'Failed to get cached products');
    }
  }

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    try {
      final jsonList = products.map((product) => product.toJson()).toList();
      final jsonString = json.encode(jsonList);
      await sharedPreferences.setString(
        AppConstants.cachedProductsKey,
        jsonString,
      );
    } catch (e) {
      developer.log('Error caching products: $e');
      throw CacheException(message: 'Failed to cache products');
    }
  }
}
