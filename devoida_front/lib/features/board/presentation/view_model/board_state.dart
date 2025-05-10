import 'package:devoida_front/features/board/data/models/board.dart';
import 'package:devoida_front/features/workspace/data/models/members.dart';

abstract class BoardState {}

class BoardInitial extends BoardState {}

class BoardLoading extends BoardState {}

class BoardSuccess extends BoardState {
  final List<Board> boards;

  BoardSuccess(this.boards);
}

class BoardFailure extends BoardState {
  final String error;

  BoardFailure(this.error);
}

class CreatedBoardSuccess extends BoardState {
  final String message;

  CreatedBoardSuccess(this.message);
}

class BoardMembersSuccess extends BoardState {
  final List<Members> members;

  BoardMembersSuccess(this.members);
}
