import 'package:devoida_front/core/utils/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../utils/helpers/spacing.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.leadingImage,
    required this.title,
    this.actions,
    this.titleStyle,
    this.backOption = false,
  });
  final String leadingImage;
  final String title;
  final List<Widget>? actions;
  final TextStyle? titleStyle;
  final bool? backOption;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96.h,
      width: double.infinity,
      color: const Color(0xFF212121),
      child: Padding(
        padding: EdgeInsets.only(top: 30.0.h, left: 14.0.w, right: 14.0.w),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            backOption!
                ? IconButton(
                  onPressed: () {
                    GoRouter.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back_ios),
                )
                : SizedBox(),
            Image.asset(leadingImage),
            widthSizedBox(8),
            Text(title, style: titleStyle ?? Styles.titleStyle),
            const Spacer(), // Pushes actions to the right
            if (actions != null) ...actions!,
          ],
        ),
      ),
    );
  }
}
