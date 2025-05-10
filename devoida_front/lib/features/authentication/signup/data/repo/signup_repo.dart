import 'package:dartz/dartz.dart';
import 'package:devoida_front/core/errors/failure.dart';
import 'package:devoida_front/core/utils/networking/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SignUpRepo {
  final ApiService api;

  SignUpRepo({required this.api});

  Future<Either<Failure, String>> signUp({
    required String username,
    required String pass,
    required String email,
    required String profilePicture,
  }) async {
    try {
      var response = await api.post(
        endPoints: 'user/',
        data: {
          "username": username,
          "email": email,
          "password_hash": pass,
          "profile_picture": "https://example.com",
        },
      );
      // print('RESPONSE CODE ==== ${response.statusCode}');
      // Check if response is successful
      if (response.statusCode == 201) {
        debugPrint(
          "=============================== ${response.data['message']}",
        );
        return right('Sign up successful');
      } else {
        // If there's an error, return a failure wrapped in ServerFailure
        return left(ServerFailure('Failed to sign up'));
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
