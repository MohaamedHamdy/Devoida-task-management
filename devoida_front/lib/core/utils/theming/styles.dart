import 'package:devoida_front/core/utils/theming/colors.dart';
import 'package:devoida_front/core/utils/theming/fonts_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Styles {
  static TextStyle titleStyle = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontsHelper.semiBold,
    color: kTextWhite,
  );

  static TextStyle cardTitleStyle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontsHelper.medium,
    color: kTextWhite,
  );

  static TextStyle subTitleStyle = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontsHelper.medium,
    color: kTextWhite,
  );
}
