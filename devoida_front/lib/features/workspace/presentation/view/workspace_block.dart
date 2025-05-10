import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/utils/helpers/spacing.dart';
import '../../../../core/utils/theming/colors.dart';
import '../../../../core/utils/theming/styles.dart';

class WorkSpaceBlock extends StatelessWidget {
  const WorkSpaceBlock({
    super.key,
    required this.id,
    required this.name,
    required this.description,
  });
  final int id;
  final String name;
  final String description;
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
                  Text(name, style: Styles.subTitleStyle),
                  Spacer(),
                  Text(
                    "Boards",
                    style: Styles.subTitleStyle.copyWith(color: kPrimaryBlue),
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
      ],
    );
  }
}
