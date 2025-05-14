import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductsByCategory {
  final ProductRepository repository;

  GetProductsByCategory(this.repository);

  Future<Either<Failure, List<Product>>> call(
      GetProductsByCategoryParams params) async {
    return await repository.getProductsByCategory(params.categoryId);
  }
}

class GetProductsByCategoryParams extends Equatable {
  final String categoryId;

  const GetProductsByCategoryParams({required this.categoryId});

  @override
  List<Object> get props => [categoryId];
}
