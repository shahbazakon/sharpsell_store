import 'dart:convert';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_service.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts({int limit = 20, int offset = 0});
  Future<List<ProductModel>> getProductsByCategory(int categoryId);
  Future<ProductModel> getProductById(int id);
  Future<List<ProductModel>> getSimilarProducts(int productId);
  Future<List<ProductModel>> searchProducts(String query);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiService apiService;

  ProductRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<ProductModel>> getProducts(
      {int limit = 20, int offset = 0}) async {
    try {
      final data = await apiService.getProducts(limit: limit, offset: offset);
      return data
          .map<ProductModel>((json) => ProductModel.fromJson(json))
          .toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(int categoryId) async {
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
  Future<ProductModel> getProductById(int id) async {
    try {
      final data = await apiService.getProductById(id);
      return ProductModel.fromJson(data);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<ProductModel>> getSimilarProducts(int productId) async {
    try {
      final data = await apiService.getSimilarProducts(productId);
      return data
          .map<ProductModel>((json) => ProductModel.fromJson(json))
          .toList();
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
