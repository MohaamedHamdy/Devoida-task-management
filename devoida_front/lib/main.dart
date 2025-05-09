import 'package:devoida_front/core/utils/routing/app_router.dart';
import 'package:devoida_front/features/home/presentation/view/home.dart';
import 'package:devoida_front/features/home/presentation/view/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          routerConfig: AppRouter.appRouter,
          debugShowCheckedModeBanner: false,
          // theme: ThemeData(fontFamily: 'Roboto'),
          theme: ThemeData.dark(),
          darkTheme: ThemeData.dark().copyWith(),
          // home: KanbanBoardSimple(),
        );
      },
    );
  }
}
