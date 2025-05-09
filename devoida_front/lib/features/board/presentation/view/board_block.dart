import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/helpers/spacing.dart';
import '../../../../core/utils/theming/styles.dart';
class BoardBlock extends StatelessWidget {
  final bool showTopBorder;
  final bool isFullBottomBorder;

  const BoardBlock({
    super.key,
    this.showTopBorder = false,
    this.isFullBottomBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            border: showTopBorder
                ? Border(
              top: BorderSide(color: Colors.white.withOpacity(0.3)),
            )
                : null,
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
                Text("Pet-Yard", style: Styles.subTitleStyle),
              ],
            ),
          ),
        ),
        if (!isFullBottomBorder)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0.w),
            child: Container(
              height: 1,
              color: Colors.white.withOpacity(0.3),
            ),
          ),
        if (isFullBottomBorder)
        // Full-width border
          Container(
            height: 1,
            color: Colors.white.withOpacity(0.3),
          ),
      ],
    );
  }
}
