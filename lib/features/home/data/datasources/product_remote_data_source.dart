import 'dart:developer' as developer;
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_service.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts({int offset = 0, int limit = 20});
  Future<List<ProductModel>> getProductsByCategory({
    required String categoryId,
    int offset = 0,
    int limit = 20,
  });
  Future<ProductModel> getProductById(String id);
  Future<List<ProductModel>> getSimilarProducts(String productId);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiService apiService;

  ProductRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<ProductModel>> getProducts(
      {int offset = 0, int limit = 20}) async {
    try {
      final response =
          await apiService.getProducts(limit: limit, offset: offset);
      return response.map((json) => ProductModel.fromJson(json)).toList();
    } catch (e) {
      developer.log('Error getting products: $e');
      throw ServerException(message: 'Failed to get products');
    }
  }

  @override
  Future<List<ProductModel>> getProductsByCategory({
    required String categoryId,
    int offset = 0,
    int limit = 20,
  }) async {
    try {
      // Filter products by category on client side since the API doesn't support this directly
      final allProducts = await getProducts(offset: offset, limit: 100);
      return allProducts
          .where((product) => product.categoryId == categoryId)
          .take(limit)
          .toList();
    } catch (e) {
      developer.log('Error getting products by category: $e');
      throw ServerException(message: 'Failed to get products by category');
    }
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    try {
      final response = await apiService.getProductById(id);
      return ProductModel.fromJson(response);
    } catch (e) {
      developer.log('Error getting product by ID: $e');
      throw ServerException(message: 'Failed to get product details');
    }
  }

  @override
  Future<List<ProductModel>> getSimilarProducts(String productId) async {
    try {
      final response = await apiService.getSimilarProducts(productId);
      return response.map((json) => ProductModel.fromJson(json)).toList();
    } catch (e) {
      developer.log('Error getting similar products: $e');
      throw ServerException(message: 'Failed to get similar products');
    }
  }
}
