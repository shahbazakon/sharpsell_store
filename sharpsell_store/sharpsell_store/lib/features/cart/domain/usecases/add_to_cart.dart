import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../entities/cart.dart';
import '../entities/cart_item.dart';
import '../repositories/cart_repository.dart';

class AddToCart {
  final CartRepository repository;

  AddToCart(this.repository);

  Future<Either<Failure, Cart>> call(AddToCartParams params) async {
    return await repository.addToCart(params.item);
  }
}

class AddToCartParams extends Equatable {
  final CartItem item;

  const AddToCartParams({required this.item});

  @override
  List<Object> get props => [item];
}
