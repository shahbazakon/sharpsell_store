import 'dart:developer' as developer;
import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_data_source.dart';
import '../datasources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Product>>> getProducts({
    int offset = 0,
    int limit = 20,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.getProducts(
          offset: offset,
          limit: limit,
        );

        // Cache products if it's the first page
        if (offset == 0) {
          await localDataSource.cacheProducts(remoteProducts);
        }

        return Right(remoteProducts);
      } on ServerException catch (e) {
        developer.log('Server exception when getting products: ${e.message}');
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        developer.log('Unexpected error when getting products: $e');
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      try {
        // Return cached data when offline
        final localProducts = await localDataSource.getLastProducts();
        return Right(localProducts);
      } on CacheException catch (e) {
        developer.log('Cache exception when getting products: ${e.message}');
        return Left(CacheFailure(message: e.message));
      } catch (e) {
        developer.log('Unexpected error when getting cached products: $e');
        return Left(CacheFailure(message: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductsByCategory({
    required String categoryId,
    int offset = 0,
    int limit = 20,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final products = await remoteDataSource.getProductsByCategory(
          categoryId: categoryId,
          offset: offset,
          limit: limit,
        );
        return Right(products);
      } on ServerException catch (e) {
        developer.log(
            'Server exception when getting products by category: ${e.message}');
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        developer.log('Unexpected error when getting products by category: $e');
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return Left(NetworkFailure(message: 'No internet connection'));
    }
  }
}
