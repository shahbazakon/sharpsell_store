import 'package:flutter/material.dart';
import '../../data/models/category_model.dart';
import '../../domain/repositories/category_repository.dart';

class CategoryProvider extends ChangeNotifier {
  final CategoryRepository categoryRepository;

  CategoryProvider({required this.categoryRepository});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  bool _hasMoreData = true;
  bool get hasMoreData => _hasMoreData;

  int _currentPage = 0;
  int _limit = 10;

  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;

  String _error = '';
  String get error => _error;

  Future<void> getCategories({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 0;
      _hasMoreData = true;
      _categories = [];
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
      final newCategories = await categoryRepository.getCategories(
          limit: _limit, offset: _currentPage * _limit);

      if (newCategories.isEmpty) {
        _hasMoreData = false;
      } else {
        _categories.addAll(newCategories);
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
}
