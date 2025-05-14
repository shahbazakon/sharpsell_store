import 'dart:convert';
import 'package:http/http.dart' as http;

import '../error/exceptions.dart';
import '../utils/constants.dart';

class ApiService {
  final http.Client client;

  ApiService({required this.client});

  Future<dynamic> get(String endpoint,
      {Map<String, dynamic>? queryParams}) async {
    final url = Uri.parse('${AppConstants.baseUrl}$endpoint')
        .replace(queryParameters: queryParams);

    try {
      final response = await client.get(
        url,
        headers: {'Content-Type': 'application/json'},
      ).timeout(Duration(milliseconds: AppConstants.connectionTimeout));

      return _processResponse(response);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return json.decode(response.body);
      case 400:
        throw ServerException(message: 'Bad request');
      case 401:
      case 403:
        throw ServerException(message: 'Unauthorized');
      case 404:
        throw ServerException(message: 'Not found');
      case 500:
      default:
        throw ServerException(message: AppConstants.serverErrorMessage);
    }
  }
}
