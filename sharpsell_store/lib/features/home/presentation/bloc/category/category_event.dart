import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class GetCategoriesEvent extends CategoryEvent {}

class SearchCategoriesEvent extends CategoryEvent {
  final String query;

  const SearchCategoriesEvent(this.query);

  @override
  List<Object> get props => [query];
}
