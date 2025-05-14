import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/api_service.dart';
import 'core/network/network_info.dart';
import 'core/utils/constants.dart';
import 'features/cart/data/datasources/cart_local_data_source.dart';
import 'features/cart/data/repositories/cart_repository_impl.dart';
import 'features/cart/domain/repositories/cart_repository.dart';
import 'features/cart/domain/usecases/add_to_cart.dart';
import 'features/cart/domain/usecases/get_cart.dart';
import 'features/cart/domain/usecases/remove_from_cart.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';
import 'features/home/data/datasources/category_local_data_source.dart';
import 'features/home/data/datasources/category_remote_data_source.dart';
import 'features/home/data/datasources/product_local_data_source.dart';
import 'features/home/data/datasources/product_remote_data_source.dart';
import 'features/home/data/repositories/category_repository_impl.dart';
import 'features/home/data/repositories/product_repository_impl.dart';
import 'features/home/domain/repositories/category_repository.dart';
import 'features/home/domain/repositories/product_repository.dart';
import 'features/home/domain/usecases/get_categories.dart';
import 'features/home/domain/usecases/get_products.dart';
import 'features/home/domain/usecases/get_products_by_category.dart';
import 'features/home/domain/usecases/search_categories.dart';
import 'features/home/presentation/bloc/category/category_bloc.dart';
import 'features/home/presentation/bloc/product/product_bloc.dart';
import 'features/product_details/domain/usecases/get_product_by_id.dart';
import 'features/product_details/domain/usecases/get_similar_products.dart';
import 'features/product_details/presentation/bloc/product_details_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  try {
    developer.log('Initializing dependencies...');

    // External dependencies
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);
    developer.log('SharedPreferences registered');

    // Configure Dio and API Service
    final dio = Dio();
    dio.options.baseUrl = AppConstants.baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 15);
    dio.options.receiveTimeout = const Duration(seconds: 15);
    dio.interceptors.add(
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
    sl.registerLazySingleton(() => dio);
    sl.registerLazySingleton(() => ApiService(sl()));
    developer.log('Dio and ApiService registered');

    // Register InternetConnectionChecker for Android
    sl.registerLazySingleton(() => InternetConnectionChecker());
    developer.log('InternetConnectionChecker registered');

    // Core
    sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(sl<InternetConnectionChecker>()),
    );
    developer.log('NetworkInfo registered');

    // Features - Home
    // Data sources
    sl.registerLazySingleton<CategoryRemoteDataSource>(
      () => CategoryRemoteDataSourceImpl(apiService: sl()),
    );
    sl.registerLazySingleton<CategoryLocalDataSource>(
      () => CategoryLocalDataSourceImpl(sharedPreferences: sl()),
    );
    sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(apiService: sl()),
    );
    sl.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(sharedPreferences: sl()),
    );
    developer.log('Data sources registered');

    // Repository
    sl.registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ),
    );
    sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ),
    );
    developer.log('Repositories registered');

    // Use cases
    sl.registerLazySingleton(() => GetCategories(sl()));
    sl.registerLazySingleton(() => SearchCategories(sl()));
    sl.registerLazySingleton(() => GetProducts(sl()));
    sl.registerLazySingleton(() => GetProductsByCategory(sl()));
    sl.registerLazySingleton(() => GetProductById(sl()));
    sl.registerLazySingleton(() => GetSimilarProducts(sl()));
    developer.log('Use cases registered');

    // Features - Product Details
    // Bloc
    sl.registerFactory(
      () => ProductDetailsBloc(
        getProductById: sl(),
        getSimilarProducts: sl(),
      ),
    );

    // Features - Cart
    // Data sources
    sl.registerLazySingleton<CartLocalDataSource>(
      () => CartLocalDataSourceImpl(sharedPreferences: sl()),
    );

    // Repository
    sl.registerLazySingleton<CartRepository>(
      () => CartRepositoryImpl(
        localDataSource: sl(),
      ),
    );

    // Use cases
    sl.registerLazySingleton(() => GetCart(sl()));
    sl.registerLazySingleton(() => AddToCart(sl()));
    sl.registerLazySingleton(() => RemoveFromCart(sl()));

    // Bloc
    sl.registerFactory(
      () => CartBloc(
        getCart: sl(),
        addToCart: sl(),
        removeFromCart: sl(),
      ),
    );

    // Bloc
    sl.registerFactory(
      () => CategoryBloc(
        getCategories: sl(),
        searchCategories: sl(),
      ),
    );
    sl.registerFactory(
      () => ProductBloc(
        getProducts: sl(),
        getProductsByCategory: sl(),
      ),
    );
    developer.log('Blocs registered');

    developer.log('All dependencies initialized successfully');
  } catch (e, stackTrace) {
    developer.log('Error initializing dependencies: $e');
    developer.log('Stack trace: $stackTrace');
    rethrow;
  }
}
