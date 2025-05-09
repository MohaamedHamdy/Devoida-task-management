import 'package:devoida_front/core/utils/helpers/spacing.dart';
import 'package:devoida_front/core/utils/theming/colors.dart';
import 'package:devoida_front/core/utils/theming/styles.dart';
import 'package:devoida_front/core/widgets/custom_app_bar.dart';
import 'package:devoida_front/core/widgets/custom_search_field.dart';
import 'package:devoida_front/features/workspace/presentation/view/workspace_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkspaceScreen extends StatelessWidget {
  const WorkspaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
        WorkSpaceBlock(),
        WorkSpaceBlock(),
        WorkSpaceBlock(),
        WorkSpaceBlock(),
      ],
    );
  }
}
