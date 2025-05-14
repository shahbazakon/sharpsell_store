import 'dart:convert';
import 'package:http/http.dart' as http;

import '../error/exceptions.dart';
import '../utils/constants.dart';

/// ApiService handles all API calls to the backend server.
/// It provides methods to get categories, products, product details, and similar products.
/// It uses the HTTP client to make requests and handles response processing.
class ApiService {
  final http.Client client;

  ApiService({required this.client});

  /// Makes a GET request to the specified endpoint with optional query parameters.
  /// Handles timeout and error cases.
  ///
  /// @param endpoint The API endpoint to call
  /// @param queryParams Optional query parameters for the request
  /// @return Parsed JSON response
  /// @throws ServerException if the request fails
  Future<dynamic> get(String endpoint,
      {Map<String, dynamic>? queryParams}) async {
    final url = Uri.parse('${AppConstants.baseUrl}$endpoint')
        .replace(queryParameters: queryParams);

    try {
      final response = await client.get(
        url,
        headers: {'Content-Type': 'application/json'},
      ).timeout(Duration(milliseconds: AppConstants.connectionTimeout));

      return _processResponse(response);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  /// Gets all categories from the API.
  /// Endpoint: /categories
  ///
  /// @return List of categories
  /// @throws ServerException if the request fails
  Future<dynamic> getCategories() async {
    return await get(AppConstants.categoriesEndpoint);
  }

  /// Gets products from the API with pagination support.
  /// Endpoint: /products?limit={limit}&offset={offset}
  ///
  /// @param limit Number of products to fetch (default: 10)
  /// @param offset Number of products to skip (default: 0)
  /// @return List of products
  /// @throws ServerException if the request fails
  Future<dynamic> getProducts({int limit = 10, int offset = 0}) async {
    return await get(
      AppConstants.productsEndpoint,
      queryParams: {
        'limit': limit.toString(),
        'offset': offset.toString(),
      },
    );
  }

  /// Gets a specific product by ID.
  /// Endpoint: /products/{id}
  ///
  /// @param id The ID of the product to fetch
  /// @return Product details
  /// @throws ServerException if the request fails
  Future<dynamic> getProductById(int id) async {
    return await get('${AppConstants.productsEndpoint}/$id');
  }

  /// Gets similar products for a specific product.
  /// Endpoint: /products/{productId}/related
  ///
  /// @param productId The ID of the product to get similar products for
  /// @return List of similar products
  /// @throws ServerException if the request fails
  Future<dynamic> getSimilarProducts(int productId) async {
    return await get(
      '${AppConstants.productsEndpoint}/$productId${AppConstants.relatedProductsEndpoint}',
    );
  }

  /// Processes the HTTP response and handles different status codes.
  ///
  /// @param response The HTTP response to process
  /// @return Parsed JSON response
  /// @throws ServerException with appropriate message based on the status code
  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return json.decode(response.body);
      case 400:
        throw ServerException(message: 'Bad request');
      case 401:
      case 403:
        throw ServerException(message: 'Unauthorized');
      case 404:
        throw ServerException(message: 'Not found');
      case 500:
      default:
        throw ServerException(message: AppConstants.serverErrorMessage);
    }
  }
}
