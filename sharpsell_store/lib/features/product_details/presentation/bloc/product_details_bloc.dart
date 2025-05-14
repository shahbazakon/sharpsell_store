import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_details_event.dart';
import 'product_details_state.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsBloc() : super(ProductDetailsInitial()) {
    on<GetProductDetailsEvent>(_onGetProductDetails);
    on<GetSimilarProductsEvent>(_onGetSimilarProducts);
  }

  Future<void> _onGetProductDetails(
    GetProductDetailsEvent event,
    Emitter<ProductDetailsState> emit,
  ) async {
    emit(ProductDetailsLoading());
    // Will be implemented later with real API calls
    emit(ProductDetailsError("Not implemented yet"));
  }

  Future<void> _onGetSimilarProducts(
    GetSimilarProductsEvent event,
    Emitter<ProductDetailsState> emit,
  ) async {
    // Will be implemented later with real API calls
    emit(ProductDetailsError("Not implemented yet"));
  }
}
