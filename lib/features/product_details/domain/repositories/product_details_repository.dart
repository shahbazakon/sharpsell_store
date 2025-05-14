import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../home/domain/entities/product.dart';

abstract class ProductDetailsRepository {
  Future<Either<Failure, Product>> getProductById(String id);
  Future<Either<Failure, List<Product>>> getSimilarProducts(String productId);
}
