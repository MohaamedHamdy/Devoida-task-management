import 'package:devoida_front/features/board/data/repo/boards_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'board_state.dart';

class BoardCubit extends Cubit<BoardState> {
  final BoardRepo boardRepo;

  BoardCubit(this.boardRepo) : super(BoardInitial());

  Future<void> createBoard({
    required String name,
    required String description,
    required int workspaceId,
  }) async {
    emit(BoardLoading());
    final result = await boardRepo.createBoard(
      name: name,
      description: description,
      workspaceId: workspaceId,
    );
    result.fold(
      (failure) => emit(BoardFailure(failure.errorMessage)),
      (message) => emit(CreatedBoardSuccess(message)),
    );
  }

  Future<void> getBoards(int workspace_id) async {
    emit(BoardLoading());
    final result = await boardRepo.getBoards(workspace_id);
    result.fold(
      (failure) => emit(BoardFailure(failure.errorMessage)),
      (boards) => emit(BoardSuccess(boards)),
    );
  }

  Future<void> getMembers(int workspaceId) async {
    final result = await boardRepo.getMembers(workspaceId);
    result.fold(
      (failure) => emit(BoardFailure(failure.errorMessage)),
      (members) => emit(BoardMembersSuccess(members)),
    );
  }
}
