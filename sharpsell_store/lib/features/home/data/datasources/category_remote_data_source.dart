import 'dart:convert';

import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../models/category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<List<CategoryModel>> searchCategories(String query);
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final Dio client;

  CategoryRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      // For demo purposes, we'll use mock data
      await Future.delayed(const Duration(seconds: 1));
      return [
        const CategoryModel(
          id: '1',
          name: 'Electronics',
          imageUrl: 'https://via.placeholder.com/150',
        ),
        const CategoryModel(
          id: '2',
          name: 'Clothing',
          imageUrl: 'https://via.placeholder.com/150',
        ),
        const CategoryModel(
          id: '3',
          name: 'Books',
          imageUrl: 'https://via.placeholder.com/150',
        ),
        const CategoryModel(
          id: '4',
          name: 'Home & Kitchen',
          imageUrl: 'https://via.placeholder.com/150',
        ),
      ];

      // In a real app, we would make an API call:
      // final response = await client.get('/categories');
      // if (response.statusCode == 200) {
      //   return (response.data as List)
      //       .map((category) => CategoryModel.fromJson(category))
      //       .toList();
      // } else {
      //   throw ServerException(message: 'Failed to load categories');
      // }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<CategoryModel>> searchCategories(String query) async {
    try {
      // For demo purposes, we'll use mock data and filter it
      final categories = await getCategories();
      return categories
          .where((category) =>
              category.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      // In a real app, we would make an API call:
      // final response = await client.get('/categories/search?q=$query');
      // if (response.statusCode == 200) {
      //   return (response.data as List)
      //       .map((category) => CategoryModel.fromJson(category))
      //       .toList();
      // } else {
      //   throw ServerException(message: 'Failed to search categories');
      // }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
