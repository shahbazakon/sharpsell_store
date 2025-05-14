import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<List<ProductModel>> getProductsByCategory(String categoryId);
  Future<ProductModel> getProductById(String id);
  Future<List<ProductModel>> getSimilarProducts(String productId);
  Future<List<ProductModel>> searchProducts(String query);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio client;

  ProductRemoteDataSourceImpl({required this.client});

  // Mock data for demonstration purposes
  final List<ProductModel> _mockProducts = [
    const ProductModel(
      id: '1',
      name: 'Smartphone X',
      description: 'Latest smartphone with amazing features',
      price: 999.99,
      imageUrl: 'https://via.placeholder.com/150',
      categoryId: '1',
      categoryName: 'Electronics',
    ),
    const ProductModel(
      id: '2',
      name: 'Laptop Pro',
      description: 'Powerful laptop for professionals',
      price: 1499.99,
      imageUrl: 'https://via.placeholder.com/150',
      categoryId: '1',
      categoryName: 'Electronics',
    ),
    const ProductModel(
      id: '3',
      name: 'T-Shirt',
      description: 'Comfortable cotton t-shirt',
      price: 19.99,
      imageUrl: 'https://via.placeholder.com/150',
      categoryId: '2',
      categoryName: 'Clothing',
    ),
    const ProductModel(
      id: '4',
      name: 'Jeans',
      description: 'Classic blue jeans',
      price: 39.99,
      imageUrl: 'https://via.placeholder.com/150',
      categoryId: '2',
      categoryName: 'Clothing',
    ),
    const ProductModel(
      id: '5',
      name: 'Novel',
      description: 'Bestselling fiction novel',
      price: 12.99,
      imageUrl: 'https://via.placeholder.com/150',
      categoryId: '3',
      categoryName: 'Books',
    ),
    const ProductModel(
      id: '6',
      name: 'Cookbook',
      description: 'Collection of delicious recipes',
      price: 24.99,
      imageUrl: 'https://via.placeholder.com/150',
      categoryId: '3',
      categoryName: 'Books',
    ),
    const ProductModel(
      id: '7',
      name: 'Coffee Maker',
      description: 'Automatic coffee maker',
      price: 89.99,
      imageUrl: 'https://via.placeholder.com/150',
      categoryId: '4',
      categoryName: 'Home & Kitchen',
    ),
    const ProductModel(
      id: '8',
      name: 'Blender',
      description: 'High-speed blender for smoothies',
      price: 49.99,
      imageUrl: 'https://via.placeholder.com/150',
      categoryId: '4',
      categoryName: 'Home & Kitchen',
    ),
  ];

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      return _mockProducts;

      // In a real app, we would make an API call:
      // final response = await client.get('/products');
      // if (response.statusCode == 200) {
      //   return (response.data as List)
      //       .map((product) => ProductModel.fromJson(product))
      //       .toList();
      // } else {
      //   throw ServerException(message: 'Failed to load products');
      // }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(String categoryId) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      return _mockProducts
          .where((product) => product.categoryId == categoryId)
          .toList();

      // In a real app, we would make an API call:
      // final response = await client.get('/products?category_id=$categoryId');
      // if (response.statusCode == 200) {
      //   return (response.data as List)
      //       .map((product) => ProductModel.fromJson(product))
      //       .toList();
      // } else {
      //   throw ServerException(message: 'Failed to load products by category');
      // }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      final product = _mockProducts.firstWhere(
        (product) => product.id == id,
        orElse: () => throw ServerException(message: 'Product not found'),
      );
      return product;

      // In a real app, we would make an API call:
      // final response = await client.get('/products/$id');
      // if (response.statusCode == 200) {
      //   return ProductModel.fromJson(response.data);
      // } else {
      //   throw ServerException(message: 'Failed to load product details');
      // }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<ProductModel>> getSimilarProducts(String productId) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // Get the category of the current product
      final product = await getProductById(productId);

      // Return other products in the same category
      return _mockProducts
          .where((p) => p.categoryId == product.categoryId && p.id != productId)
          .toList();

      // In a real app, we would make an API call:
      // final response = await client.get('/products/$productId/similar');
      // if (response.statusCode == 200) {
      //   return (response.data as List)
      //       .map((product) => ProductModel.fromJson(product))
      //       .toList();
      // } else {
      //   throw ServerException(message: 'Failed to load similar products');
      // }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // Filter products by name or description containing the query
      return _mockProducts
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()) ||
              product.description.toLowerCase().contains(query.toLowerCase()))
          .toList();

      // In a real app, we would make an API call:
      // final response = await client.get('/products/search?q=$query');
      // if (response.statusCode == 200) {
      //   return (response.data as List)
      //       .map((product) => ProductModel.fromJson(product))
      //       .toList();
      // } else {
      //   throw ServerException(message: 'Failed to search products');
      // }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
