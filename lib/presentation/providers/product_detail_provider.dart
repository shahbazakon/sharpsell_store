import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';
import '../../domain/repositories/product_repository.dart';

class ProductDetailProvider extends ChangeNotifier {
  final ProductRepository productRepository;

  ProductDetailProvider({required this.productRepository});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isLoadingRelated = false;
  bool get isLoadingRelated => _isLoadingRelated;

  ProductModel? _product;
  ProductModel? get product => _product;

  List<ProductModel> _relatedProducts = [];
  List<ProductModel> get relatedProducts => _relatedProducts;

  String _error = '';
  String get error => _error;

  String _relatedError = '';
  String get relatedError => _relatedError;

  Future<void> getProductById(int id) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _product = await productRepository.getProductById(id);
      _isLoading = false;
      notifyListeners();

      // Load related products after loading the main product
      getRelatedProducts(id);
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> getRelatedProducts(int productId) async {
    _isLoadingRelated = true;
    _relatedError = '';
    notifyListeners();

    try {
      _relatedProducts = await productRepository.getRelatedProducts(productId);
      _isLoadingRelated = false;
      notifyListeners();
    } catch (e) {
      _isLoadingRelated = false;
      _relatedError = e.toString();
      notifyListeners();
    }
  }

  void clear() {
    _product = null;
    _relatedProducts = [];
    _error = '';
    _relatedError = '';
    notifyListeners();
  }
}
