import 'dart:developer' as developer;
import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/category_local_data_source.dart';
import '../datasources/category_remote_data_source.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;
  final CategoryLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CategoryRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCategories = await remoteDataSource.getCategories();
        await localDataSource.cacheCategories(remoteCategories);
        return Right(remoteCategories);
      } on ServerException catch (e) {
        developer.log('Server exception when getting categories: ${e.message}');
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        developer.log('Unexpected error when getting categories: $e');
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      try {
        final localCategories = await localDataSource.getLastCategories();
        return Right(localCategories);
      } on CacheException catch (e) {
        developer.log('Cache exception when getting categories: ${e.message}');
        return Left(CacheFailure(message: e.message));
      } catch (e) {
        developer.log('Unexpected error when getting cached categories: $e');
        return Left(CacheFailure(message: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<Category>>> searchCategories(String query) async {
    if (await networkInfo.isConnected) {
      try {
        final categories = await remoteDataSource.searchCategories(query);
        return Right(categories);
      } on ServerException catch (e) {
        developer
            .log('Server exception when searching categories: ${e.message}');
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        developer.log('Unexpected error when searching categories: $e');
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      try {
        final localCategories = await localDataSource.getLastCategories();
        final filteredCategories = localCategories
            .where((category) =>
                category.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
        return Right(filteredCategories);
      } on CacheException catch (e) {
        developer
            .log('Cache exception when searching categories: ${e.message}');
        return Left(CacheFailure(message: e.message));
      } catch (e) {
        developer.log('Unexpected error when searching cached categories: $e');
        return Left(CacheFailure(message: e.toString()));
      }
    }
  }
}
