import 'package:dartz/dartz.dart';
import 'package:devoida_front/core/errors/failure.dart';
import 'package:devoida_front/core/utils/networking/api_service.dart';
import 'package:devoida_front/features/workspace/data/models/worspace.dart';
import 'package:dio/dio.dart';

class WorkspaceRepo {
  final ApiService api;

  WorkspaceRepo({required this.api});

  Future<Either<Failure, String>> createWorkspace({
    required String name,
    required String description,
  }) async {
    try {
      // print("object");
      var response = await api.post(
        endPoints: 'workspace/',
        data: {"name": name, "description": description},
      );
      // print(response);
      // Check if response is successful
      if (response.statusCode == 200) {
        return right("success");
      } else {
        // Handle error response
        return left(ServerFailure(response.data['message']));
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<Worspace>>> getCreatedWorkspaces() async {
    try {
      await api.setAuthorizationHeader();
      // print("sads");
      var response = await api.get(endpoint: "workspace");
      // print("object");
      // print(response);

      if (response['Status'] == 'Success') {
        List data = response['data'];
        List<Worspace> workspaces =
            data.map((e) => Worspace.fromJson(e)).toList();
        return right(workspaces);
      } else {
        print('fail + ${response['message']}');
        return left(ServerFailure(response['message']));
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<Worspace>>> getWorkspaces() async {
    try {
      await api.setAuthorizationHeader();
      var response = await api.get(endpoint: "workspace/workspaces");
      // print(response);
      // Check if response is successful
      if (response['Status'] == 'Success') {
        List data = response['data'];
        List<Worspace> workspaces =
            data.map((e) => Worspace.fromJson(e)).toList();
        return right(workspaces);
      } else {
        // Handle error response

        return left(ServerFailure(response['message']));
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
