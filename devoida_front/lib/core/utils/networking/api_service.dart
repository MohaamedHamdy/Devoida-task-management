import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  final baseUrl = 'http://192.168.1.2:8000/';

  Dio dio;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  ApiService({required this.dio});

  var headers = {'Content-Type': 'application/json'};

  Future<void> setAuthorizationHeader() async {
    try {
      // Retrieve token from secure storage
      final token = await _storage.read(key: 'token');

      // print('tokennnn $token');
      // Check if token exists
      if (token != null) {
        // Add token to the headers of the Dio instance
        dio.options.headers['Authorization'] = 'Bearer $token';
      } else {
        // If token is null, user is not authenticated
        // Handle the case accordingly, such as redirecting to login screen
        // or displaying an error message
        // Example: throw Exception('User not authenticated');
      }
    } catch (error) {
      // Handle error retrieving token from secure storage
      // Example: print('Error retrieving token: $error');
      // You can rethrow the error or handle it gracefully based on your requirements
      // rethrow;
    }
  }

  Future<Response> post({
    required String endPoints,
    required Map<String, dynamic> data,
  }) async {
    try {
      var response = await dio.post(
        '$baseUrl$endPoints',
        data: data,
        options: Options(method: 'POST', headers: headers),
      );
      return response;
    } catch (error) {
      debugPrint(' $error');
      rethrow; // Re-throw the error for handling in the caller
    }
  }

  Future<Map<String, dynamic>> get({required String endpoint}) async {
    // await setAuthorizationHeader();
    // print('Request Headers: ${dio.options.headers}');
    // print(endpoint);
    var response = await dio.get('$baseUrl$endpoint');

    return response.data;
  }

  Future<Response> delete({required String endPoints}) async {
    try {
      var response = await dio.delete(
        '$baseUrl$endPoints',
        options: Options(method: 'DELETE', headers: headers),
      );
      return response;
    } catch (error) {
      debugPrint('Delete error: $error');
      rethrow;
    }
  }

  Future<Response> put({
    required String endPoints,
    required Map<String, dynamic> data,
  }) async {
    try {
      await setAuthorizationHeader();

      var response = await dio.put(
        '$baseUrl$endPoints',
        data: data,
        options: Options(method: 'PUT', headers: headers),
      );
      return response;
    } catch (error) {
      debugPrint('Put error: $error');
      rethrow;
    }
  }
}
