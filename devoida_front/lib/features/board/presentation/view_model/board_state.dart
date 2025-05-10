import 'package:devoida_front/features/board/data/models/board.dart';

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
