import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts({
    int offset = 0,
    int limit = 20,
  });

  Future<Either<Failure, List<Product>>> getProductsByCategory({
    required String categoryId,
    int offset = 0,
    int limit = 20,
  });
}
