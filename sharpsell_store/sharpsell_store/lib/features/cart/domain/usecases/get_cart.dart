import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/cart.dart';
import '../repositories/cart_repository.dart';

class GetCart {
  final CartRepository repository;

  GetCart(this.repository);

  Future<Either<Failure, Cart>> call() async {
    return await repository.getCart();
  }
}
