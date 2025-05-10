import 'package:devoida_front/core/utils/helpers/spacing.dart';
import 'package:devoida_front/core/utils/networking/api_service.dart';
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

// Inside AllBoards class (make it StatefulWidget)
class AllBoards extends StatefulWidget {
  const AllBoards({super.key, required this.workspaceId});
  final int workspaceId;

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
                    const Spacer(),
                    IconButton(
                      onPressed: () => showCreateBoardDialog(cubit),
                      icon: Icon(Icons.add, color: kPrimaryBlue, size: 30.sp),
                    ),
                  ],
                ),
                heightSizedBox(40),
                Expanded(child: BoardList()),
              ],
            );
          },
        ),
      ),
    );
  }
}

class BoardList extends StatelessWidget {
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
              return BoardBlock(
                name: board.name ?? "no-name",
                showTopBorder: index == 0,
                isFullBottomBorder: index == state.boards.length - 1,
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
