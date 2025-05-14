import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductsByCategory {
  final ProductRepository repository;

  GetProductsByCategory(this.repository);

  Future<Either<Failure, List<Product>>> call({
    required String categoryId,
    int offset = 0,
    int limit = 20,
  }) async {
    return await repository.getProductsByCategory(
      categoryId: categoryId,
      offset: offset,
      limit: limit,
    );
  }
}
