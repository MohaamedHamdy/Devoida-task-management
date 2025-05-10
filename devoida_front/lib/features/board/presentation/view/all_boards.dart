import 'package:devoida_front/core/utils/helpers/spacing.dart';
import 'package:devoida_front/core/utils/networking/api_service.dart';
import 'package:devoida_front/core/utils/routing/routes.dart';
import 'package:devoida_front/core/utils/theming/colors.dart';
import 'package:devoida_front/core/utils/theming/styles.dart';
import 'package:devoida_front/core/widgets/custom_app_bar.dart';
import 'package:devoida_front/features/board/data/repo/boards_repo.dart';
import 'package:devoida_front/features/board/presentation/view/board_block.dart';
import 'package:devoida_front/features/board/presentation/view_model/board_cubit.dart';
import 'package:devoida_front/features/board/presentation/view_model/board_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

Color getAvatarColor(int index) {
  final colors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.cyan,
    Colors.indigo,
    Colors.amber,
    Colors.deepOrange,
  ];
  return colors[index % colors.length];
}

class AllBoards extends StatefulWidget {
  const AllBoards({
    super.key,
    required this.workspaceId,
    required this.workspaceName,
  });
  final int workspaceId;
  final String workspaceName;
  @override
  State<AllBoards> createState() => _AllBoardsState();
}

class _AllBoardsState extends State<AllBoards> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  void showCreateBoardDialog(BoardCubit cubit) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Create Board", style: TextStyle(fontSize: 20.sp)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Board Name",
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
                  labelText: "Board Description",
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
                  final description = descriptionController.text.trim();

                  if (name.isNotEmpty && description.isNotEmpty) {
                    await cubit.createBoard(
                      name: name,
                      description: description,
                      workspaceId: widget.workspaceId,
                    );

                    await cubit.getBoards(widget.workspaceId);
                    nameController.clear();
                    descriptionController.clear();

                    if (mounted) Navigator.of(context).pop();
                  }
                },
                child: Text("Create", style: TextStyle(fontSize: 16.sp)),
              ),
            ],
          ),
        );
      },
    );
  }

  // void showMembersDialog(BuildContext context, BoardCubit cubit) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       cubit.getMembers(widget.workspaceId);

  //       return AlertDialog(
  //         title: Text("Workspace Members", style: TextStyle(fontSize: 20.sp)),

  //         content: BlocBuilder<BoardCubit, BoardState>(
  //           buildWhen:
  //               (previous, current) =>
  //                   current is BoardMembersSuccess ||
  //                   current is BoardFailure ||
  //                   current is BoardLoading,
  //           builder: (context, state) {
  //             if (state is BoardLoading) {
  //               return Center(child: CircularProgressIndicator());
  //             } else if (state is BoardFailure) {
  //               return Text("Failed to load members: ${state.error}");
  //             } else if (state is BoardMembersSuccess) {
  //               final members = state.members;

  //               if (members.isEmpty) {
  //                 return Text("No members found.");
  //               }

  //               return SizedBox(
  //                 width: double.maxFinite,
  //                 child: ListView.builder(
  //                   shrinkWrap: true,
  //                   itemCount: members.length,
  //                   itemBuilder: (context, index) {
  //                     final member = members[index];
  //                     final name = member.username ?? "Unnamed";
  //                     final initial =
  //                         name.isNotEmpty ? name[0].toUpperCase() : "?";
  //                     return ListTile(
  //                       leading: CircleAvatar(
  //                         backgroundColor: getAvatarColor(index),
  //                         child: Text(
  //                           initial,
  //                           style: const TextStyle(color: Colors.white),
  //                         ),
  //                       ),
  //                       title: Text(name),
  //                     );
  //                   },
  //                 ),
  //               );
  //             } else {
  //               return const SizedBox.shrink();
  //             }
  //           },
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              BoardCubit(BoardRepo(api: ApiService(dio: Dio())))
                ..getBoards(widget.workspaceId),
      child: Scaffold(
        body: BlocBuilder<BoardCubit, BoardState>(
          builder: (context, state) {
            final cubit = context.read<BoardCubit>();

            return Column(
              children: [
                CustomAppBar(
                  backOption: true,
                  leadingImage: "assets/images/Trello.png",
                  title: "Boards",
                  titleStyle: Styles.titleStyle.copyWith(color: kPrimaryBlue),
                  actions: [
                    TextButton(
                      // onPressed: () => showMembersDialog(context, cubit),
                      onPressed: () {},
                      child: Text(
                        "Members",
                        style: TextStyle(color: kPrimaryBlue, fontSize: 16.sp),
                      ),
                    ),
                    IconButton(
                      onPressed: () => showCreateBoardDialog(cubit),
                      icon: Icon(Icons.add, color: kPrimaryBlue, size: 30.sp),
                    ),
                  ],
                ),
                heightSizedBox(20),
                // BlocBuilder<BoardCubit, BoardState>(
                //   buildWhen: (prev, curr) => curr is BoardMembersSuccess,
                //   builder: (context, state) {
                //     if (state is BoardMembersSuccess) {
                //       return SizedBox(
                //         height: 40.h,
                //         child: ListView.builder(
                //           scrollDirection: Axis.horizontal,
                //           itemCount: state.members.length,
                //           itemBuilder: (context, index) {
                //             final member = state.members[index];
                //             final name = member.username;
                //             final initial =
                //                 name!.isNotEmpty ? name[0].toUpperCase() : '?';
                //             return Padding(
                //               padding: EdgeInsets.symmetric(horizontal: 8.w),
                //               child: Tooltip(
                //                 message: name,
                //                 child: CircleAvatar(
                //                   backgroundColor: getAvatarColor(index),
                //                   radius: 30.r,
                //                   child: Text(
                //                     initial,
                //                     style: TextStyle(
                //                       color: Colors.white,
                //                       fontSize: 20.sp,
                //                       fontWeight: FontWeight.bold,
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             );
                //           },
                //         ),
                //       );
                //     } else {
                //       return SizedBox();
                //     }
                //   },
                // ),
                Expanded(child: BoardList(workspaceName: widget.workspaceName)),
              ],
            );
          },
        ),
      ),
    );
  }
}

class BoardList extends StatelessWidget {
  final String workspaceName;

  const BoardList({super.key, required this.workspaceName});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BoardCubit, BoardState>(
      builder: (context, state) {
        if (state is BoardLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is BoardSuccess) {
          return ListView.builder(
            itemCount: state.boards.length,
            itemBuilder: (context, index) {
              final board = state.boards[index];
              return InkWell(
                onTap: () {
                  GoRouter.of(context).push(
                    Routes.kBoardTasksScreen,
                    extra: {
                      'workspaceName': workspaceName,
                      'boardName': board.name,
                    },
                  );
                },

                child: BoardBlock(
                  name: board.name ?? "no-name",
                  showTopBorder: index == 0,
                  isFullBottomBorder: index == state.boards.length - 1,
                ),
              );
            },
          );
        } else if (state is BoardFailure) {
          return Center(child: Text(state.error));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
