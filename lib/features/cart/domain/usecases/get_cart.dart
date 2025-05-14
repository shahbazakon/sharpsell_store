import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/cart_item.dart';
import '../repositories/cart_repository.dart';

class GetCart {
  final CartRepository repository;

  GetCart(this.repository);

  Future<Either<Failure, List<CartItem>>> call() async {
    return await repository.getCartItems();
  }
}
