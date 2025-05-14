import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  // Features - Home
  // Bloc
  sl.registerFactory(
    () => CategoryBloc(getCategories: sl(), searchCategories: sl()),
  );

  sl.registerFactory(
    () => ProductBloc(getProducts: sl(), getProductsByCategory: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetCategories(sl()));
  sl.registerLazySingleton(() => SearchCategories(sl()));
  sl.registerLazySingleton(() => GetProducts(sl()));
  sl.registerLazySingleton(() => GetProductsByCategory(sl()));

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

  // Data sources
  sl.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<CategoryLocalDataSource>(
    () => CategoryLocalDataSourceImpl(sharedPreferences: sl()),
  );

  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Features - Product Details
  // Bloc
  sl.registerFactory(
    () => ProductDetailsBloc(getProductById: sl(), getSimilarProducts: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetProductById(sl()));
  sl.registerLazySingleton(() => GetSimilarProducts(sl()));

  // Features - Cart
  // Bloc
  sl.registerFactory(
    () => CartBloc(getCart: sl(), addToCart: sl(), removeFromCart: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetCart(sl()));
  sl.registerLazySingleton(() => AddToCart(sl()));
  sl.registerLazySingleton(() => RemoveFromCart(sl()));

  // Repository
  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<CartLocalDataSource>(
    () => CartLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Configure Dio
  final dio = Dio();
  dio.options.baseUrl = AppConstants.baseUrl;
  dio.options.connectTimeout = const Duration(seconds: 5);
  dio.options.receiveTimeout = const Duration(seconds: 3);
  dio.options.headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  sl.registerLazySingleton(() => dio);

  sl.registerLazySingleton(() => InternetConnectionChecker());
}
