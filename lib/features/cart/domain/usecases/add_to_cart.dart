import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/cart_item.dart';
import '../repositories/cart_repository.dart';

class AddToCart {
  final CartRepository repository;

  AddToCart(this.repository);

  Future<Either<Failure, List<CartItem>>> call(CartItem item) async {
    return await repository.addToCart(item);
  }
}
