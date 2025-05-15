import 'package:equatable/equatable.dart';
import 'package:sharpsell_store/data/models/product_model.dart';

import '../repositories/product_repository.dart';

class GetProducts {
  final ProductRepository repository;

  GetProducts(this.repository);

  Future<List<ProductModel>> call(ProductParams params) async {
    return await repository.getProducts(
        // limit: params.limit,
        // offset: params.offset,
        );
  }
}

class ProductParams extends Equatable {
  final int limit;
  final int offset;

  const ProductParams({
    this.limit = 10,
    this.offset = 0,
  });

  @override
  List<Object?> get props => [limit, offset];
}
