import 'package:devoida_front/features/workspace/data/models/worspace.dart';
import 'package:equatable/equatable.dart';

abstract class WorkspaceState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WorkspaceInitial extends WorkspaceState {}

class WorkspaceLoading extends WorkspaceState {}

class WorkspaceSuccess extends WorkspaceState {
  final List<Worspace> workspaces;
  WorkspaceSuccess(this.workspaces);
}

class WorkspaceFailure extends WorkspaceState {
  final String error;
  WorkspaceFailure(this.error);
}

// Optional: If you want to distinguish both APIs
class CreatedWorkspaceSuccess extends WorkspaceState {
  final String message;
  CreatedWorkspaceSuccess(this.message);
}

class AllWorkspacesSuccess extends WorkspaceState {
  final String message;
  AllWorkspacesSuccess(this.message);
}
