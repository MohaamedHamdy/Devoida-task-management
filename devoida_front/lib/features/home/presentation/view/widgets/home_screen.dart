import 'package:devoida_front/core/utils/helpers/spacing.dart';
import 'package:devoida_front/core/utils/theming/colors.dart';
import 'package:devoida_front/core/utils/theming/styles.dart';
import 'package:devoida_front/core/widgets/custom_app_bar.dart';
import 'package:devoida_front/core/widgets/custom_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            child: Column(children: [
              CustomTextField(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Workspaces",
                  width: double.infinity,
                  controller: TextEditingController(),)
            ]),
          ),
        ],
      ),
    );
  }
}
