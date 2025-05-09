import 'package:devoida_front/core/utils/routing/routes.dart';
import 'package:devoida_front/core/utils/routing/routing_animation.dart';
import 'package:devoida_front/features/home/presentation/view/home.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static final GoRouter appRouter = GoRouter(
    initialLocation: Routes.kHomeScreen,
    routes: [
      GoRoute(
        path: Routes.kHomeScreen,
        pageBuilder: (context, state) => transitionGoRoute(
          context: context,
          state: state,
          child: const HomeScreen(),
        ),
      ),
    ],
  );
}