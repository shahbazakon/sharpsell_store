import 'dart:developer' as developer;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_products.dart';
import '../../../domain/usecases/get_products_by_category.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;
  final GetProductsByCategory getProductsByCategory;

  int _page = 0;
  final int _limit = 20;
  bool _hasReachedMax = false;

  ProductBloc({
    required this.getProducts,
    required this.getProductsByCategory,
  }) : super(ProductInitial()) {
    on<GetProductsEvent>(_onGetProducts);
    on<LoadMoreProductsEvent>(_onLoadMoreProducts);
    on<GetProductsByCategoryEvent>(_onGetProductsByCategory);
    on<LoadMoreProductsByCategoryEvent>(_onLoadMoreProductsByCategory);
  }

  Future<void> _onGetProducts(
    GetProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductLoading());
    _page = 0;
    _hasReachedMax = false;

    final result = await getProducts(offset: _page * _limit, limit: _limit);

    result.fold(
      (failure) {
        developer.log('Failed to get products: ${failure.message}');
        emit(ProductError(message: failure.message));
      },
      (products) {
        _page++;
        _hasReachedMax = products.length < _limit;
        emit(ProductLoaded(
          products: products,
          hasReachedMax: _hasReachedMax,
        ));
      },
    );
  }

  Future<void> _onLoadMoreProducts(
    LoadMoreProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    if (_hasReachedMax) return;

    if (state is ProductLoaded) {
      final currentProducts = (state as ProductLoaded).products;
      emit(ProductLoading(products: currentProducts, isFirstLoad: false));

      final result = await getProducts(offset: _page * _limit, limit: _limit);

      result.fold(
        (failure) {
          developer.log('Failed to load more products: ${failure.message}');
          emit(ProductLoaded(products: currentProducts));
        },
        (newProducts) {
          _page++;
          _hasReachedMax = newProducts.isEmpty || newProducts.length < _limit;

          emit(ProductLoaded(
            products: [...currentProducts, ...newProducts],
            hasReachedMax: _hasReachedMax,
          ));
        },
      );
    }
  }

  Future<void> _onGetProductsByCategory(
    GetProductsByCategoryEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductLoading());
    _page = 0;
    _hasReachedMax = false;

    final result = await getProductsByCategory(
      categoryId: event.categoryId,
      offset: _page * _limit,
      limit: _limit,
    );

    result.fold(
      (failure) {
        developer.log('Failed to get products by category: ${failure.message}');
        emit(ProductError(message: failure.message));
      },
      (products) {
        _page++;
        _hasReachedMax = products.length < _limit;
        emit(ProductLoaded(
          products: products,
          hasReachedMax: _hasReachedMax,
        ));
      },
    );
  }

  Future<void> _onLoadMoreProductsByCategory(
    LoadMoreProductsByCategoryEvent event,
    Emitter<ProductState> emit,
  ) async {
    if (_hasReachedMax) return;

    if (state is ProductLoaded) {
      final currentProducts = (state as ProductLoaded).products;
      emit(ProductLoading(products: currentProducts, isFirstLoad: false));

      final result = await getProductsByCategory(
        categoryId: event.categoryId,
        offset: _page * _limit,
        limit: _limit,
      );

      result.fold(
        (failure) {
          developer.log(
              'Failed to load more products by category: ${failure.message}');
          emit(ProductLoaded(products: currentProducts));
        },
        (newProducts) {
          _page++;
          _hasReachedMax = newProducts.isEmpty || newProducts.length < _limit;

          emit(ProductLoaded(
            products: [...currentProducts, ...newProducts],
            hasReachedMax: _hasReachedMax,
          ));
        },
      );
    }
  }
}
