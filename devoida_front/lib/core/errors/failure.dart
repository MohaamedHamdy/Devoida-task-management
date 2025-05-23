import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;

  const Failure(this.errorMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMessage);

  factory ServerFailure.fromDioError(DioException dioError) {
    String errorMessage =
        'Oops, something went wrong!'; // Default error message

    if (dioError.response?.data is Map) {
      errorMessage = dioError.response?.data['message'] ?? errorMessage;
    } else if (dioError.response?.data is String) {
      errorMessage = dioError.response?.data ?? errorMessage;
    }

    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection Timeout!');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send Timeout!');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive Timeout!');
      case DioExceptionType.badResponse:
        if (dioError.response?.statusCode == 401 ||
            dioError.response?.statusCode == 400 ||
            dioError.response?.statusCode == 404 ||
            dioError.response?.statusCode == 403) {
          return ServerFailure(errorMessage);
        } else {
          return ServerFailure('Bad Request!');
        }
      case DioExceptionType.cancel:
        return ServerFailure('Request was canceled!');
      case DioExceptionType.unknown:
        return ServerFailure('Unknown Error!');
      default:
        return ServerFailure('Oops, something went wrong!');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    String errorMessage =
        'Oops, something went wrong!'; // Default error message

    if (response is Map && response.containsKey('message')) {
      errorMessage = response['message'];
    } else if (response is String) {
      errorMessage = response;
    }

    switch (statusCode) {
      case 400:
        return ServerFailure(errorMessage);
      case 401:
        return ServerFailure('Unauthorized!');
      case 403:
        return ServerFailure('Forbidden!');
      case 404:
        return ServerFailure('Not Found!');
      case 500:
        return ServerFailure('Internal Server Error!');
      default:
        return ServerFailure('Oops, something went wrong!');
    }
  }
}
