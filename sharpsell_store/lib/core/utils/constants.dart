/// AppConstants contains all the constants used throughout the application.
/// This includes API endpoints, timeout values, error messages, and cache keys.
class AppConstants {
  // App Information
  /// The name of the application as shown in the UI
  static const String appName = 'Sharpsell Store';

  // API Constants
  /// Base URL for the API endpoints - Fake Store API from escuelajs.co
  static const String baseUrl = 'https://api.escuelajs.co/api/v1';

  /// Endpoint to get all products or a specific product by ID: /products or /products/{id}
  static const String productsEndpoint = '/products';

  /// Endpoint to get all categories: /categories
  static const String categoriesEndpoint = '/categories';

  /// Endpoint to get similar/related products: /products/{id}/related
  static const String relatedProductsEndpoint = '/related';

  // Pagination
  /// Default number of items to fetch in one API call
  static const int defaultLimit = 10;

  /// Default offset for pagination
  static const int defaultOffset = 0;

  // Network
  /// Timeout for API connections (30 seconds)
  static const int connectionTimeout = 30000; // 30 seconds
  /// Timeout for receiving API responses (30 seconds)
  static const int receiveTimeout = 30000; // 30 seconds

  // Error Messages
  /// Message displayed when there is no internet connection
  static const String networkErrorMessage =
      'Please check your internet connection';

  /// Message displayed when there is a server error
  static const String serverErrorMessage =
      'Server error occurred. Please try again later';

  /// Message displayed for unknown errors
  static const String unknownErrorMessage = 'An unknown error occurred';

  // Cache Keys
  /// Key for caching cart items in SharedPreferences
  static const String cachedCartKey = 'CART_ITEMS';

  /// Key for caching categories in SharedPreferences
  static const String cachedCategoriesKey = 'CACHED_CATEGORIES';

  /// Key for caching products in SharedPreferences
  static const String cachedProductsKey = 'CACHED_PRODUCTS';
}
