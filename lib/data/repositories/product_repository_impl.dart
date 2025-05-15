import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';
import '../models/product_model.dart';
import '../../core/network/network_info.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<List<ProductModel>> getProducts(
      {int limit = 10, int offset = 0}) async {
    if (await networkInfo.isConnected) {
      try {
        return await remoteDataSource.getProducts(limit: limit, offset: offset);
      } catch (e) {
        throw Exception('Failed to load products: $e');
      }
    } else {
      throw Exception('No internet connection');
    }
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    if (await networkInfo.isConnected) {
      try {
        return await remoteDataSource.getProductById(id);
      } catch (e) {
        throw Exception('Failed to load product: $e');
      }
    } else {
      throw Exception('No internet connection');
    }
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(int categoryId,
      {int limit = 10, int offset = 0}) async {
    if (await networkInfo.isConnected) {
      try {
        return await remoteDataSource.getProductsByCategory(categoryId,
            limit: limit, offset: offset);
      } catch (e) {
        throw Exception('Failed to load products by category: $e');
      }
    } else {
      throw Exception('No internet connection');
    }
  }

  @override
  Future<List<ProductModel>> getRelatedProducts(int productId) async {
    if (await networkInfo.isConnected) {
      try {
        return await remoteDataSource.getRelatedProducts(productId);
      } catch (e) {
        throw Exception('Failed to load related products: $e');
      }
    } else {
      throw Exception('No internet connection');
    }
  }

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    if (await networkInfo.isConnected) {
      try {
        return await remoteDataSource.searchProducts(query);
      } catch (e) {
        throw Exception('Failed to search products: $e');
      }
    } else {
      throw Exception('No internet connection');
    }
  }
}
