import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../home/domain/entities/product.dart';
import '../repositories/product_details_repository.dart';

class GetProductById {
  final ProductDetailsRepository repository;

  GetProductById(this.repository);

  Future<Either<Failure, Product>> call(String id) async {
    return await repository.getProductById(id);
  }
}
