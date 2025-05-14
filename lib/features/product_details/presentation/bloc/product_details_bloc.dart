import 'dart:developer' as developer;
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
  }

  Future<void> _onGetProductDetails(
    GetProductDetailsEvent event,
    Emitter<ProductDetailsState> emit,
  ) async {
    emit(ProductDetailsLoading());

    // Get product details
    final productResult = await getProductById(event.productId);

    await productResult.fold(
      (failure) {
        developer.log('Failed to get product details: ${failure.message}');
        emit(ProductDetailsError(message: failure.message));
      },
      (product) async {
        // Get similar products
        final similarProductsResult = await getSimilarProducts(event.productId);

        similarProductsResult.fold(
          (failure) {
            developer.log('Failed to get similar products: ${failure.message}');
            // Still show the product but with empty similar products
            emit(ProductDetailsLoaded(product: product));
          },
          (similarProducts) {
            emit(ProductDetailsLoaded(
              product: product,
              similarProducts: similarProducts,
            ));
          },
        );
      },
    );
  }
}
