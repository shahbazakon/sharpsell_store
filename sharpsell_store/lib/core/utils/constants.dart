class AppConstants {
  // App Information
  static const String appName = 'Sharpsell Store';

  // API Constants
  static const String baseUrl = 'https://api.escuelajs.co/api/v1';
  static const String productsEndpoint = '/products';
  static const String categoriesEndpoint = '/categories';
  static const String relatedProductsEndpoint = '/related';

  // Pagination
  static const int defaultLimit = 10;
  static const int defaultOffset = 0;

  // Network
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds

  // Error Messages
  static const String networkErrorMessage =
      'Please check your internet connection';
  static const String serverErrorMessage =
      'Server error occurred. Please try again later';
  static const String unknownErrorMessage = 'An unknown error occurred';

  // Cache Keys
  static const String cartCacheKey = 'CART_ITEMS';
}
