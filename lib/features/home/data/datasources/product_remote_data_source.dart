import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/constants.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts({int limit = 20, int offset = 0});
  Future<List<ProductModel>> getProductsByCategory(String categoryId);
  Future<ProductModel> getProductById(String id);
  Future<List<ProductModel>> getSimilarProducts(String productId);
  Future<List<ProductModel>> searchProducts(String query);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio client;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProductModel>> getProducts({
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final response = await client.get(
        '${AppConstants.baseUrl}/products',
        queryParameters: {'limit': limit, 'offset': offset},
      );

      if (response.statusCode == 200) {
        return (response.data as List)
            .map((product) => ProductModel.fromJson(product))
            .toList();
      } else {
        throw ServerException(message: 'Failed to load products');
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(String categoryId) async {
    try {
      // API doesn't have a direct endpoint for products by category
      // So we'll get all products and filter them
      final products = await getProducts(limit: 100);
      return products
          .where((product) => product.categoryId == categoryId)
          .toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    try {
      final response = await client.get('${AppConstants.baseUrl}/products/$id');

      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data);
      } else {
        throw ServerException(message: 'Failed to load product details');
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<ProductModel>> getSimilarProducts(String productId) async {
    try {
      final response = await client.get(
        '${AppConstants.baseUrl}/products/$productId/related',
      );

      if (response.statusCode == 200) {
        return (response.data as List)
            .map((product) => ProductModel.fromJson(product))
            .toList();
      } else {
        throw ServerException(message: 'Failed to load similar products');
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      // API doesn't have a search endpoint, so we'll get all products and filter them
      final products = await getProducts(limit: 100);
      return products
          .where(
            (product) =>
                product.name.toLowerCase().contains(query.toLowerCase()) ||
                product.description.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
