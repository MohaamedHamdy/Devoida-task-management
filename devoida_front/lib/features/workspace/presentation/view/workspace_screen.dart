import 'package:devoida_front/core/utils/helpers/spacing.dart';
import 'package:devoida_front/core/utils/networking/api_service.dart';
import 'package:devoida_front/core/utils/theming/colors.dart';
import 'package:devoida_front/core/utils/theming/styles.dart';
import 'package:devoida_front/core/widgets/custom_app_bar.dart';
import 'package:devoida_front/core/widgets/custom_search_field.dart';
import 'package:devoida_front/features/workspace/data/repo/workspace_repo.dart';
import 'package:devoida_front/features/workspace/presentation/view/workspace_block.dart';
import 'package:devoida_front/features/workspace/presentation/view_model/workspace_cubit.dart';
import 'package:devoida_front/features/workspace/presentation/view_model/workspace_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkspaceScreen extends StatefulWidget {
  const WorkspaceScreen({super.key});

  @override
  State<WorkspaceScreen> createState() => _WorkspaceScreenState();
}

class _WorkspaceScreenState extends State<WorkspaceScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              WorkspaceCubit(WorkspaceRepo(api: ApiService(dio: Dio())))
                ..getAllWorkspaces(),
      child: BlocBuilder<WorkspaceCubit, WorkspaceState>(
        builder: (context, state) {
          final cubit = context.read<WorkspaceCubit>();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                leadingImage: "assets/images/Trello.png",
                title: "Devoida",
                titleStyle: Styles.titleStyle.copyWith(color: kPrimaryBlue),
                actions: [
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: Text(
                              "Create Workspace",
                              style: TextStyle(fontSize: 20.sp),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    labelText: "Workspace Name",
                                    filled: true,
                                    fillColor: Colors.grey.withOpacity(0.1),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                  ),
                                ),
                                heightSizedBox(10),
                                TextFormField(
                                  controller: descriptionController,
                                  minLines: 3,
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                    labelText: "Workspace Description",
                                    filled: true,
                                    fillColor: Colors.grey.withOpacity(0.1),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                  ),
                                ),
                                heightSizedBox(20),
                                ElevatedButton(
                                  onPressed: () async {
                                    final name = nameController.text.trim();
                                    final description =
                                        descriptionController.text.trim();

                                    if (name.isNotEmpty &&
                                        description.isNotEmpty) {
                                      await cubit.createWorkspace(
                                        name: name,
                                        description: description,
                                      );
                                      await cubit.getAllWorkspaces();

                                      nameController.clear();
                                      descriptionController.clear();

                                      if (mounted) Navigator.of(context).pop();
                                    }
                                  },
                                  child: Text(
                                    "Create",
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.add, color: kPrimaryBlue, size: 30.sp),
                  ),
                ],
              ),
              const WorkSpaceScreenBody(), // Use cubit already provided
            ],
          );
        },
      ),
    );
  }
}

class WorkSpaceScreenBody extends StatelessWidget {
  const WorkSpaceScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkspaceCubit, WorkspaceState>(
      builder: (context, state) {
        if (state is WorkspaceLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is WorkspaceSuccess) {
          final workspaces = state.workspaces;

          return Column(
            children: [
              heightSizedBox(20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      prefixIcon: Icon(Icons.search),
                      hintText: "Workspaces",
                      width: double.infinity,
                      controller: TextEditingController(),
                    ),
                    heightSizedBox(50),
                    Text("YOUR WORKSPACES", style: Styles.cardTitleStyle),
                    heightSizedBox(20),
                  ],
                ),
              ),
              ...workspaces.map(
                (workspace) => WorkSpaceBlock(
                  id: workspace.id ?? 0,
                  name: workspace.name ?? "Unnamed",
                  description: workspace.description ?? "",
                ),
              ),
            ],
          );
        } else if (state is WorkspaceFailure) {
          return Center(child: Text(state.error));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
