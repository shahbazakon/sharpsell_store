import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../home/domain/entities/product.dart';
import '../repositories/product_details_repository.dart';

class GetSimilarProducts {
  final ProductDetailsRepository repository;

  GetSimilarProducts(this.repository);

  Future<Either<Failure, List<Product>>> call(String productId) async {
    return await repository.getSimilarProducts(productId);
  }
}
