import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_products.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;

  ProductBloc({
    required this.getProducts,
  }) : super(ProductInitial()) {
    on<GetProductsEvent>(_onGetProducts);
    on<GetProductsByCategoryEvent>(_onGetProductsByCategory);
  }

  Future<void> _onGetProducts(
    GetProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    final result = await getProducts();
    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (products) => emit(ProductLoaded(products)),
    );
  }

  Future<void> _onGetProductsByCategory(
    GetProductsByCategoryEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    // Will be implemented later
    emit(ProductError("Get products by category not implemented yet"));
  }
}
