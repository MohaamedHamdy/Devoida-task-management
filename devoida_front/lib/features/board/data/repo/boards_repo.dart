import 'package:dartz/dartz.dart';
import 'package:devoida_front/core/errors/failure.dart';
import 'package:devoida_front/core/utils/networking/api_service.dart';
import 'package:devoida_front/features/board/data/models/board.dart';
import 'package:devoida_front/features/workspace/data/models/members.dart';
import 'package:devoida_front/features/workspace/data/models/worspace.dart';
import 'package:dio/dio.dart';

class BoardRepo {
  final ApiService api;

  BoardRepo({required this.api});

  Future<Either<Failure, String>> createBoard({
    required String name,
    required String description,
    required int workspaceId,
  }) async {
    try {
      // print("object");
      var response = await api.post(
        endPoints: 'boards/',
        data: {
          "name": name,
          "description": description,
          "workspace_id": workspaceId,
        },
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

  Future<Either<Failure, List<Board>>> getBoards(int workspace_id) async {
    try {
      await api.setAuthorizationHeader();
      var response = await api.get(endpoint: "boards/$workspace_id");
      if (response['Status'] == 'Success') {
        List data = response['data'];
        List<Board> boards = data.map((e) => Board.fromJson(e)).toList();
        return right(boards);
      } else {
        return left(ServerFailure(response['message']));
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<Members>>> getMembers(int workspaceId) async {
    try {
      await api.setAuthorizationHeader();
      var response = await api.get(endpoint: "workspace/$workspaceId/members");
      // print(response);
      // Check if response is successful
      if (response['Status'] == 'Success') {
        List data = response['data'];
        List<Members> members = data.map((e) => Members.fromJson(e)).toList();
        return right(members);
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
