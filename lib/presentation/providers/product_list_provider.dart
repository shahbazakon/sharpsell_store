import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';
import '../../domain/repositories/product_repository.dart';

class ProductListProvider extends ChangeNotifier {
  final ProductRepository productRepository;

  ProductListProvider({required this.productRepository});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  bool _hasMoreData = true;
  bool get hasMoreData => _hasMoreData;

  int _currentPage = 0;
  int _limit = 10;

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  String _error = '';
  String get error => _error;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  Future<void> getProducts({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 0;
      _hasMoreData = true;
      _products = [];
    }

    if (!_hasMoreData) return;

    if (_currentPage == 0) {
      _isLoading = true;
    } else {
      _isLoadingMore = true;
    }

    _error = '';
    notifyListeners();

    try {
      final newProducts = await productRepository.getProducts(
          limit: _limit, offset: _currentPage * _limit);

      if (newProducts.isEmpty) {
        _hasMoreData = false;
      } else {
        _products.addAll(newProducts);
        _currentPage++;
      }

      _isLoading = false;
      _isLoadingMore = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _isLoadingMore = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> getProductsByCategory(int categoryId,
      {bool refresh = false}) async {
    if (refresh) {
      _currentPage = 0;
      _hasMoreData = true;
      _products = [];
    }

    if (!_hasMoreData) return;

    if (_currentPage == 0) {
      _isLoading = true;
    } else {
      _isLoadingMore = true;
    }

    _error = '';
    notifyListeners();

    try {
      final newProducts = await productRepository.getProductsByCategory(
          categoryId,
          limit: _limit,
          offset: _currentPage * _limit);

      if (newProducts.isEmpty) {
        _hasMoreData = false;
      } else {
        _products.addAll(newProducts);
        _currentPage++;
      }

      _isLoading = false;
      _isLoadingMore = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _isLoadingMore = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> searchProducts(String query) async {
    _searchQuery = query;
    if (query.isEmpty) {
      getProducts(refresh: true);
      return;
    }

    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _products = await productRepository.searchProducts(query);
      _isLoading = false;
      _hasMoreData = false; // No pagination for search results
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  void resetSearch() {
    _searchQuery = '';
    getProducts(refresh: true);
  }
}
