import 'package:devoida_front/core/utils/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

InputBorder customEnabledOutlinedBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10.0.r),
  borderSide: BorderSide(
    color: Colors.white.withOpacity(0.2),
    width: 2.0,
  ),
);

InputBorder customFocusedOutlinedBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10.0.r),
  borderSide: const BorderSide(
    // color: Color.fromRGBO(0, 170, 91, 1),
    color: kPrimaryBlue,
    width: 2.0,
  ),
);
InputBorder customErrorOutlinedBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10.0.r),
  borderSide: const BorderSide(
    color: Colors.red,
    width: 2.0,
  ),
);

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hintText = 'HINT',
    this.keyboardType,
    required this.width,
    required this.controller,
    this.height = 60,
    this.isPassword = false,
    this.isObsecure,
    this.validator,
    this.suffixIcon,
    this.onChanged,
    this.prefixIcon,
  });

  final String hintText;
  final TextInputType? keyboardType;
  final double width;
  final double height;
  final bool? isPassword;
  final bool? isObsecure;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool isVisible = false;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {},
      controller: controller,
      validator: validator,
      obscureText: isObsecure ?? false,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        constraints: BoxConstraints.tightForFinite(width: width),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.5),
          fontSize: 14.sp,
        ),
        enabledBorder: customEnabledOutlinedBorder,
        focusedBorder: customFocusedOutlinedBorder,
        errorBorder: customErrorOutlinedBorder,
        border: customEnabledOutlinedBorder,
      ),
    );
  }
}