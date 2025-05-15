import '../../core/network/network_info.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/category_remote_data_source.dart';
import '../models/category_model.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  CategoryRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<List<CategoryModel>> getCategories(
      {int limit = 10, int offset = 0}) async {
    if (await networkInfo.isConnected) {
      try {
        return await remoteDataSource.getCategories(
            limit: limit, offset: offset);
      } catch (e) {
        throw Exception('Failed to load categories: $e');
      }
    } else {
      throw Exception('No internet connection');
    }
  }
}
