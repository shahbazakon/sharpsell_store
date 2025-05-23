import '../models/product_model.dart';
import '../../core/network/api_client.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts({int limit = 10, int offset = 0});
  Future<ProductModel> getProductById(int id);
  Future<List<ProductModel>> getProductsByCategory(int categoryId,
      {int limit = 10, int offset = 0});
  Future<List<ProductModel>> getRelatedProducts(int productId);
  Future<List<ProductModel>> searchProducts(String query);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiClient apiClient;

  ProductRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<ProductModel>> getProducts(
      {int limit = 10, int offset = 0}) async {
    try {
      final response =
          await apiClient.get('products?limit=$limit&offset=$offset');
      return (response as List)
          .map((product) => ProductModel.fromJson(product))
          .toList();
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    try {
      final response = await apiClient.get('products/$id');
      return ProductModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to load product details: $e');
    }
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(int categoryId,
      {int limit = 10, int offset = 0}) async {
    try {
      final response = await apiClient
          .get('categories/$categoryId/products?limit=$limit&offset=$offset');
      return (response as List)
          .map((product) => ProductModel.fromJson(product))
          .toList();
    } catch (e) {
      throw Exception('Failed to load products by category: $e');
    }
  }

  @override
  Future<List<ProductModel>> getRelatedProducts(int productId) async {
    try {
      final response = await apiClient.get('products/$productId/related');
      return (response as List)
          .map((product) => ProductModel.fromJson(product))
          .toList();
    } catch (e) {
      throw Exception('Failed to load related products: $e');
    }
  }

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      // Use the API's title parameter for searching
      final response = await apiClient
          .get('products/?title=${Uri.encodeComponent(query)}&limit=20');
      final products = (response as List)
          .map((product) => ProductModel.fromJson(product))
          .toList();

      // If the API search returns no results, try a more comprehensive search
      if (products.isEmpty) {
        final allResponse = await apiClient.get('products?limit=100');
        final allProducts = (allResponse as List)
            .map((product) => ProductModel.fromJson(product))
            .toList();

        // Filter products by title or description containing the query
        return allProducts
            .where((product) =>
                product.title.toLowerCase().contains(query.toLowerCase()) ||
                product.description.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }

      return products;
    } catch (e) {
      throw Exception('Failed to search products: $e');
    }
  }
}
