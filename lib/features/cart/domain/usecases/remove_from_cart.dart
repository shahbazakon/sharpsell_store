import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/cart_item.dart';
import '../repositories/cart_repository.dart';

class RemoveFromCart {
  final CartRepository repository;

  RemoveFromCart(this.repository);

  Future<Either<Failure, List<CartItem>>> call(String id) async {
    return await repository.removeFromCart(id);
  }
}
