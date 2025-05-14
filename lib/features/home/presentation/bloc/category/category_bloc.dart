import 'dart:developer' as developer;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_categories.dart';
import '../../../domain/usecases/search_categories.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategories getCategories;
  final SearchCategories searchCategories;

  CategoryBloc({
    required this.getCategories,
    required this.searchCategories,
  }) : super(CategoryInitial()) {
    on<GetCategoriesEvent>(_onGetCategories);
    on<SearchCategoriesEvent>(_onSearchCategories);
  }

  Future<void> _onGetCategories(
    GetCategoriesEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());

    final result = await getCategories();

    result.fold(
      (failure) {
        developer.log('Failed to get categories: ${failure.message}');
        emit(CategoryError(message: failure.message));
      },
      (categories) {
        emit(CategoryLoaded(categories: categories));
      },
    );
  }

  Future<void> _onSearchCategories(
    SearchCategoriesEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());

    final result = await searchCategories(event.query);

    result.fold(
      (failure) {
        developer.log('Failed to search categories: ${failure.message}');
        emit(CategoryError(message: failure.message));
      },
      (categories) {
        emit(CategoryLoaded(categories: categories));
      },
    );
  }
}
