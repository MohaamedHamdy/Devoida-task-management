import 'package:devoida_front/features/board/presentation/view/board_block.dart';
import 'package:devoida_front/features/workspace/presentation/view/workspace_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/helpers/spacing.dart';
import '../../../../core/utils/theming/colors.dart';
import '../../../../core/utils/theming/styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_search_field.dart';

class BoardScreen extends StatelessWidget {
  const BoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
            leadingImage: "assets/images/Trello.png",
            title: "Devoida",
            titleStyle: Styles.titleStyle.copyWith(color: kPrimaryBlue),
            actions: [
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.add, color: kPrimaryBlue, size: 30.sp),
              ),
            ],
          ),
          heightSizedBox(20),
          Padding(
            padding: EdgeInsets.only(left: 14.0.w, right: 14.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Boards",
                  width: double.infinity,
                  controller: TextEditingController(),
                ),
                heightSizedBox(50),
                Text("YOUR WORKSPACES", style: Styles.cardTitleStyle),
                heightSizedBox(20),
              ],
            ),
          ),
          WorkspaceBoardsBlock(),
          heightSizedBox(10),
        ],
      ),
    );
  }
}

class WorkspaceBoardsBlock extends StatelessWidget {
  const WorkspaceBoardsBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WorkSpaceBlock(),
        BoardBlock(showTopBorder: true,),
        BoardBlock(),
        BoardBlock(),
        BoardBlock(isFullBottomBorder: true,)
      ],
    );
  }
}
