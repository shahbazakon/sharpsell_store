import '../../data/models/product_model.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> getProducts({int limit = 10, int offset = 0});
  Future<ProductModel> getProductById(int id);
  Future<List<ProductModel>> getProductsByCategory(int categoryId,
      {int limit = 10, int offset = 0});
  Future<List<ProductModel>> getRelatedProducts(int productId);
  Future<List<ProductModel>> searchProducts(String query);
}
