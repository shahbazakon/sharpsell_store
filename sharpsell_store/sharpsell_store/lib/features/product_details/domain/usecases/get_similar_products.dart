import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../home/domain/entities/product.dart';
import '../../../home/domain/repositories/product_repository.dart';

class GetSimilarProducts {
  final ProductRepository repository;

  GetSimilarProducts(this.repository);

  Future<Either<Failure, List<Product>>> call(
      GetSimilarProductsParams params) async {
    return await repository.getSimilarProducts(params.productId);
  }
}

class GetSimilarProductsParams extends Equatable {
  final String productId;

  const GetSimilarProductsParams({required this.productId});

  @override
  List<Object> get props => [productId];
}
