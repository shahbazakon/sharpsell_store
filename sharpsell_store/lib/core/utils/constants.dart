class AppConstants {
  static const String appName = 'Sharpsell Store';

  // API Constants
  static const String baseUrl = 'https://api.sharpsellstore.com';

  // Cache Keys
  static const String cachedCategoriesKey = 'CACHED_CATEGORIES';
  static const String cachedProductsKey = 'CACHED_PRODUCTS';
  static const String cachedCartKey = 'CACHED_CART';

  // Error Messages
  static const String serverErrorMessage =
      'Server error occurred. Please try again later.';
  static const String cacheErrorMessage =
      'Cache error occurred. Please try again later.';
  static const String networkErrorMessage =
      'No internet connection. Please check your connection and try again.';
}
