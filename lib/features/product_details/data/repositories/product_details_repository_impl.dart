import 'dart:developer' as developer;
import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../home/data/datasources/product_remote_data_source.dart';
import '../../../home/domain/entities/product.dart';
import '../../domain/repositories/product_details_repository.dart';

class ProductDetailsRepositoryImpl implements ProductDetailsRepository {
  final ProductRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProductDetailsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Product>> getProductById(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final product = await remoteDataSource.getProductById(id);
        return Right(product);
      } on ServerException catch (e) {
        developer
            .log('Server exception when getting product details: ${e.message}');
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        developer.log('Unexpected error when getting product details: $e');
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return Left(NetworkFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getSimilarProducts(
      String productId) async {
    if (await networkInfo.isConnected) {
      try {
        final products = await remoteDataSource.getSimilarProducts(productId);
        return Right(products);
      } on ServerException catch (e) {
        developer.log(
            'Server exception when getting similar products: ${e.message}');
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        developer.log('Unexpected error when getting similar products: $e');
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return Left(NetworkFailure(message: 'No internet connection'));
    }
  }
}
