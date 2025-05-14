import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/category.dart';
import '../repositories/category_repository.dart';

class SearchCategories {
  final CategoryRepository repository;

  SearchCategories(this.repository);

  Future<Either<Failure, List<Category>>> call(String query) async {
    return await repository.searchCategories(query);
  }
}
