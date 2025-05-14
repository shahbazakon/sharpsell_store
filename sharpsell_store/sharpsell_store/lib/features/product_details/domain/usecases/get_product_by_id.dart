import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../home/domain/entities/product.dart';
import '../../../home/domain/repositories/product_repository.dart';

class GetProductById {
  final ProductRepository repository;

  GetProductById(this.repository);

  Future<Either<Failure, Product>> call(GetProductByIdParams params) async {
    return await repository.getProductById(params.id);
  }
}

class GetProductByIdParams extends Equatable {
  final String id;

  const GetProductByIdParams({required this.id});

  @override
  List<Object> get props => [id];
}
