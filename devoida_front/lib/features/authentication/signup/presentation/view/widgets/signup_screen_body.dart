import 'package:devoida_front/core/utils/helpers/spacing.dart';
import 'package:devoida_front/core/utils/networking/api_service.dart';
import 'package:devoida_front/core/utils/routing/routes.dart';
import 'package:devoida_front/core/utils/theming/colors.dart';
import 'package:devoida_front/core/utils/theming/styles.dart';
import 'package:devoida_front/core/widgets/loading_button.dart';
import 'package:devoida_front/features/authentication/signup/data/repo/signup_repo.dart';
import 'package:devoida_front/features/authentication/signup/presentation/view%20model/sign_up_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignupScreenBody extends StatefulWidget {
  const SignupScreenBody({super.key});

  @override
  State<SignupScreenBody> createState() => _SignupScreenBodyState();
}

class _SignupScreenBodyState extends State<SignupScreenBody> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Form(
          key: _formKey,
          child: Column(
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
              heightSizedBox(30),
              GestureDetector(
                onTap: () {
                  // Pick image logic here
                },
                child: CircleAvatar(
                  radius: 50.r,
                  backgroundColor: Colors.grey.withOpacity(0.3),
                  child: Icon(
                    Icons.camera_alt,
                    size: 30.sp,
                    color: Colors.white70,
                  ),
                ),
              ),
              heightSizedBox(20),
              TextFormField(
                controller: _usernameController,
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Enter username'
                            : null,
                decoration: InputDecoration(
                  hintText: "Username",
                  hintStyle: TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
              heightSizedBox(12),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator:
                    (value) =>
                        value == null || !value.contains('@')
                            ? 'Enter a valid email'
                            : null,
                decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
              heightSizedBox(12),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                validator:
                    (value) =>
                        value == null || value.length < 6
                            ? 'Minimum 6 characters'
                            : null,
                decoration: InputDecoration(
                  hintText: "Password",
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.1),
                  hintStyle: TextStyle(color: Colors.white54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
              heightSizedBox(20),

              BlocProvider(
                create:
                    (context) =>
                        SignUpCubit(SignUpRepo(api: ApiService(dio: Dio()))),
                child: BlocConsumer<SignUpCubit, SignUpState>(
                  builder: (context, state) {
                    var cubit = BlocProvider.of<SignUpCubit>(context);
                    if (state is SignUpLoading) {
                      return const LoadingButton(height: 60, radius: 10);
                    }
                    return TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          debugPrint("Username: ${_usernameController.text}");
                          debugPrint("Email: ${_emailController.text}");
                          debugPrint("Password: ${_passwordController.text}");
                          cubit.signUp(
                            username: _usernameController.text,
                            pass: _passwordController.text,
                            email: _emailController.text,
                          );
                        }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: kPrimaryBlue,
                        minimumSize: Size(double.infinity, 50.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0.r),
                        ),
                      ),
                      child: Text("Sign Up", style: Styles.cardTitleStyle),
                    );
                  },
                  listener: (context, state) {
                    if (state is SignUpFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage)),
                      );
                    } else if (state is SignUpSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("User created successfully")),
                      );
                      GoRouter.of(context).push(Routes.kSigninScreen);
                    }
                  },
                ),
              ),
              heightSizedBox(20),
              RichText(
                text: TextSpan(
                  text: "Already have an account? ",
                  style: Styles.titleStyle.copyWith(fontSize: 14.sp),
                  children: [
                    TextSpan(
                      text: "Sign in",
                      style: Styles.titleStyle.copyWith(
                        color: kPrimaryBlue,
                        decoration: TextDecoration.underline,
                        fontSize: 14.sp,
                      ),
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              GoRouter.of(context).push(Routes.kSigninScreen);
                            },
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
