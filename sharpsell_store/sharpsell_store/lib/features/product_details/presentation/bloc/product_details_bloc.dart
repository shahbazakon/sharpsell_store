import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_product_by_id.dart';
import '../../domain/usecases/get_similar_products.dart';
import 'product_details_event.dart';
import 'product_details_state.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  final GetProductById getProductById;
  final GetSimilarProducts getSimilarProducts;

  ProductDetailsBloc({
    required this.getProductById,
    required this.getSimilarProducts,
  }) : super(ProductDetailsInitial()) {
    on<GetProductDetailsEvent>(_onGetProductDetails);
    on<GetSimilarProductsEvent>(_onGetSimilarProducts);
  }

  Future<void> _onGetProductDetails(
    GetProductDetailsEvent event,
    Emitter<ProductDetailsState> emit,
  ) async {
    emit(ProductDetailsLoading());
    final result =
        await getProductById(GetProductByIdParams(id: event.productId));

    result.fold(
      (failure) => emit(ProductDetailsError(failure.message)),
      (product) => emit(ProductDetailsLoaded(product: product)),
    );
  }

  Future<void> _onGetSimilarProducts(
    GetSimilarProductsEvent event,
    Emitter<ProductDetailsState> emit,
  ) async {
    final currentState = state;
    if (currentState is ProductDetailsLoaded) {
      emit(currentState.copyWith(similarProducts: []));
    }

    final result = await getSimilarProducts(
      GetSimilarProductsParams(productId: event.productId),
    );

    if (state is ProductDetailsLoaded) {
      result.fold(
        (failure) => emit(ProductDetailsError(failure.message)),
        (similarProducts) => emit(
          (state as ProductDetailsLoaded)
              .copyWith(similarProducts: similarProducts),
        ),
      );
    }
  }
}
