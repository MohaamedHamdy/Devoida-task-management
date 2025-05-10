import 'package:devoida_front/core/utils/helpers/spacing.dart';
import 'package:devoida_front/core/utils/routing/routes.dart';
import 'package:devoida_front/core/utils/theming/colors.dart';
import 'package:devoida_front/core/utils/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w),
          child: ListView(
            children: [
              heightSizedBox(40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/Trello.png", scale: 0.5),
                  widthSizedBox(6),
                  Text("Devoida", style: Styles.titleStyle),
                ],
              ),
              SvgPicture.asset(
                "assets/svgs/onboarding.svg",
                height: 350.h,
                fit: BoxFit.cover,
              ),
              // Image.asset("assets/images/onboarding1.png"),
              heightSizedBox(20),
              Text(
                "Move teamwork forward - even on the go",
                style: Styles.titleStyle,
              ),
              heightSizedBox(40),
              TextButton(
                onPressed: () {
                  GoRouter.of(context).push(Routes.kSigninScreen);
                },
                style: TextButton.styleFrom(
                  backgroundColor: kPrimaryBlue,
                  minimumSize: Size(double.infinity, 50.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0.r),
                  ),
                ),
                child: Text("Log in", style: Styles.cardTitleStyle),
              ),
              heightSizedBox(10),
              TextButton(
                onPressed: () {
                  GoRouter.of(context).push(Routes.kSignupScreen);
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  minimumSize: Size(double.infinity, 50.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0.r),
                    side: BorderSide(color: Colors.black, width: 2.0.w),
                  ),
                ),
                child: Text("Sign Up", style: Styles.cardTitleStyle),
              ),

              const Spacer(),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'By signing up, you agree to the\n',
                  style: Styles.subTitleStyle,
                  children: [
                    TextSpan(
                      text: 'User Notice',
                      style: Styles.subTitleStyle.copyWith(
                        decoration: TextDecoration.underline,
                        color: kPrimaryBlue,
                      ),
                    ),
                    TextSpan(text: ' and ', style: Styles.subTitleStyle),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: Styles.subTitleStyle.copyWith(
                        decoration: TextDecoration.underline,
                        color: kPrimaryBlue,
                      ),
                    ),
                  ],
                ),
              ),
              heightSizedBox(20),
            ],
          ),
        ),
      ),
    );
  }
}
