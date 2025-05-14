import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../entities/cart.dart';
import '../repositories/cart_repository.dart';

class RemoveFromCart {
  final CartRepository repository;

  RemoveFromCart(this.repository);

  Future<Either<Failure, Cart>> call(RemoveFromCartParams params) async {
    return await repository.removeFromCart(params.itemId);
  }
}

class RemoveFromCartParams extends Equatable {
  final String itemId;

  const RemoveFromCartParams({required this.itemId});

  @override
  List<Object> get props => [itemId];
}
