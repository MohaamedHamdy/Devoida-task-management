import 'package:devoida_front/core/utils/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({super.key, this.height = 50.0, this.radius = 12.0});
  final double? height;
  final double? radius;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: kPrimaryBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius!.r),
        ),
        minimumSize: Size(double.infinity, height!.h),
      ),
      child: Center(
        child: SizedBox(
          height: 20.sp,
          width: 20.sp,
          child: const CircularProgressIndicator(color: Colors.white),
        ),
      ),
    );
  }
}
