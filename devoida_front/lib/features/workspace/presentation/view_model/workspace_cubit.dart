import 'package:devoida_front/features/workspace/data/repo/workspace_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'workspace_state.dart';

class WorkspaceCubit extends Cubit<WorkspaceState> {
  final WorkspaceRepo workspaceRepo;

  WorkspaceCubit(this.workspaceRepo) : super(WorkspaceInitial());

  Future<void> createWorkspace({
    required String name,
    required String description,
  }) async {
    emit(WorkspaceLoading());
    final result = await workspaceRepo.createWorkspace(
      name: name,
      description: description,
    );
    result.fold(
      (failure) => emit(WorkspaceFailure(failure.errorMessage)),
      (message) => emit(CreatedWorkspaceSuccess(message)),
    );
  }

  Future<void> getCreatedWorkspaces() async {
    emit(WorkspaceLoading());
    // print("test");
    final result = await workspaceRepo.getCreatedWorkspaces();
    result.fold(
      (failure) => emit(WorkspaceFailure(failure.errorMessage)),
      (workspaces) => emit(WorkspaceSuccess(workspaces)),
    );
  }

  Future<void> getAllWorkspaces() async {
    emit(WorkspaceLoading());
    final result = await workspaceRepo.getWorkspaces();
    result.fold(
      (failure) => emit(WorkspaceFailure(failure.errorMessage)),
      (workspaces) => emit(WorkspaceSuccess(workspaces)),
    );
  }
}
