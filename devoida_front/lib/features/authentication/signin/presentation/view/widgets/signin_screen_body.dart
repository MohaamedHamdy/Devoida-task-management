import 'package:devoida_front/core/utils/helpers/spacing.dart';
import 'package:devoida_front/core/utils/networking/api_service.dart';
import 'package:devoida_front/core/utils/routing/routes.dart';
import 'package:devoida_front/core/utils/theming/colors.dart';
import 'package:devoida_front/core/utils/theming/styles.dart';
import 'package:devoida_front/core/widgets/loading_button.dart';
import 'package:devoida_front/features/authentication/signin/data/repo/signin_repo.dart';
import 'package:devoida_front/features/authentication/signin/presentation/view%20model/sign_in_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SigninScreenBody extends StatefulWidget {
  const SigninScreenBody({super.key});

  @override
  State<SigninScreenBody> createState() => _SigninScreenBodyState();
}

class _SigninScreenBodyState extends State<SigninScreenBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              heightSizedBox(60),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/Trello.png", scale: 0.5),
                  widthSizedBox(6),
                  Text("Devoida", style: Styles.titleStyle),
                ],
              ),
              heightSizedBox(40),

              // Email Field
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email is required';
                  }
                  if (!RegExp(r'^\S+@\S+\.\S+$').hasMatch(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              heightSizedBox(12),

              // Password Field
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Password is required';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              heightSizedBox(30),

              BlocProvider(
                create:
                    (context) =>
                        SignInCubit(SignInRepo(api: ApiService(dio: Dio()))),
                child: BlocConsumer<SignInCubit, SignInState>(
                  listener: (context, state) {
                    if (state is SignInFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage)),
                      );
                    } else if (state is SignInSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Login Successful')),
                      );
                      GoRouter.of(context).push(Routes.kHomeScreen);
                    }
                  },
                  builder: (context, state) {
                    var cubit = BlocProvider.of<SignInCubit>(context);
                    if (state is SignInLoading) {
                      return const LoadingButton(height: 60, radius: 10);
                    }
                    return SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final email = _emailController.text.trim();
                            final password = _passwordController.text.trim();
                            print('Email: $email');
                            print('Password: $password');

                            cubit.signIn(password: password, email: email);
                          }
                        },
                        child: Text("Sign In", style: Styles.cardTitleStyle),
                      ),
                    );
                  },
                ),
              ),

              // Sign In Button
              heightSizedBox(30),

              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Don't have an account? ",
                  style: Styles.titleStyle.copyWith(fontSize: 14.sp),
                  children: [
                    TextSpan(
                      text: "Sign up",
                      style: Styles.titleStyle.copyWith(
                        fontSize: 14.sp,
                        color: kPrimaryBlue,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              GoRouter.of(context).push(Routes.kSignupScreen);
                            },
                    ),
                  ],
                ),
              ),
              heightSizedBox(40),
            ],
          ),
        ),
      ),
    );
  }
}
