import 'package:dio/dio.dart';
import 'dart:developer' as developer;
import '../utils/constants.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio) {
    _dio.options.baseUrl = AppConstants.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 15);
    _dio.options.receiveTimeout = const Duration(seconds: 15);
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    // Add logging interceptor for debugging
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        logPrint: (object) => developer.log(object.toString()),
      ),
    );
  }

  // Get all products with pagination
  Future<List<dynamic>> getProducts({int limit = 20, int offset = 0}) async {
    try {
      developer.log('Fetching products with limit: $limit, offset: $offset');
      final response = await _dio.get(
        '/products',
        queryParameters: {'limit': limit, 'offset': offset},
      );
      return response.data;
    } catch (e) {
      developer.log('Error fetching products: $e');
      throw _handleError(e);
    }
  }

  // Get product details by ID
  Future<dynamic> getProductById(String id) async {
    try {
      developer.log('Fetching product with ID: $id');
      final response = await _dio.get('/products/$id');
      return response.data;
    } catch (e) {
      developer.log('Error fetching product details: $e');
      throw _handleError(e);
    }
  }

  // Get similar products
  Future<List<dynamic>> getSimilarProducts(String productId) async {
    try {
      developer.log('Fetching similar products for ID: $productId');
      final response = await _dio.get('/products/$productId/related');
      return response.data;
    } catch (e) {
      developer.log('Error fetching similar products: $e');
      throw _handleError(e);
    }
  }

  // Get all categories
  Future<List<dynamic>> getCategories({int limit = 20}) async {
    try {
      developer.log('Fetching categories with limit: $limit');
      final response = await _dio.get(
        '/categories',
        queryParameters: {'limit': limit},
      );
      return response.data;
    } catch (e) {
      developer.log('Error fetching categories: $e');
      throw _handleError(e);
    }
  }

  // Error handling
  Exception _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return Exception('Connection timeout. Please try again later.');
        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode;
          final responseData = error.response?.data;
          return Exception(
            'Error $statusCode: ${responseData ?? 'Unknown error'}',
          );
        case DioExceptionType.cancel:
          return Exception('Request was cancelled');
        default:
          return Exception('Network error: ${error.message}');
      }
    }
    return Exception('Unexpected error: $error');
  }
}
