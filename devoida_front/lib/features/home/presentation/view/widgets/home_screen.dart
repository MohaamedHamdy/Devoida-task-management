import 'package:devoida_front/core/utils/helpers/spacing.dart';
import 'package:devoida_front/core/utils/theming/colors.dart';
import 'package:devoida_front/core/utils/theming/styles.dart';
import 'package:devoida_front/core/widgets/custom_app_bar.dart';
import 'package:devoida_front/core/widgets/custom_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: const Color(0xFF212121),
      //   leading: Image.asset('assets/images/Trello.png'),
      //   title: Text('Devoida', style: Styles.titleStyle,),
      // ),
      body: Column(
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
        ],
      ),
    );
  }
}

class WorkSpaceBlock extends StatelessWidget {
  const WorkSpaceBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 14.0.w, right: 14.0.w),
          child: InkWell(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10.0.h),
              child: Row(
                children: [
                  Icon(Iconsax.people, color: kTextWhite),
                  widthSizedBox(10),
                  Text("Devoida Workspace", style: Styles.subTitleStyle),
                  Spacer(),
                  Text(
                    "Boards",
                    style: Styles.subTitleStyle.copyWith(
                      color: kPrimaryBlue,
                    ),
                  ),
                  widthSizedBox(10),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: kPrimaryBlue,
                    size: 16.sp,
                  ),
                ],
              ),
            ),
          ),
        ),
        heightSizedBox(4),
        Container(
          height: 60.h,
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.symmetric(horizontal: BorderSide(color: Colors.white.withOpacity(0.3))),
              color: Colors.white.withOpacity(0.1)
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0.w),
            child: Row(
              children: [
                Container(
                  height: 40.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.r),
                    color: Colors.pink,
                  ),
                ),
                widthSizedBox(10),
                Text("Pet-Yard", style: Styles.subTitleStyle,)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
