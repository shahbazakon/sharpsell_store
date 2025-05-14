import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../entities/category.dart';
import '../repositories/category_repository.dart';

class SearchCategories {
  final CategoryRepository repository;

  SearchCategories(this.repository);

  Future<Either<Failure, List<Category>>> call(
      SearchCategoriesParams params) async {
    return await repository.searchCategories(params.query);
  }
}

class SearchCategoriesParams extends Equatable {
  final String query;

  const SearchCategoriesParams({required this.query});

  @override
  List<Object> get props => [query];
}
