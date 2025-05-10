import 'package:devoida_front/core/utils/routing/routes.dart';
import 'package:devoida_front/core/utils/routing/routing_animation.dart';
import 'package:devoida_front/features/authentication/signin/presentation/view/signin.dart';
import 'package:devoida_front/features/authentication/signup/presentation/view/signup.dart';
import 'package:devoida_front/features/board/presentation/view/all_boards.dart';
import 'package:devoida_front/features/home/presentation/view/home.dart';
import 'package:devoida_front/features/onBoarding/presentation/onBoarding.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static final GoRouter appRouter = GoRouter(
    initialLocation: Routes.kOnBoardingScreen,
    routes: [
      GoRoute(
        path: Routes.kOnBoardingScreen,
        pageBuilder:
            (context, state) => transitionGoRoute(
              context: context,
              state: state,
              child: const Onboarding(),
            ),
      ),
      GoRoute(
        path: Routes.kSignupScreen,
        pageBuilder:
            (context, state) => transitionGoRoute(
              context: context,
              state: state,
              child: const SignUpScreen(),
            ),
      ),
      GoRoute(
        path: Routes.kSigninScreen,
        pageBuilder:
            (context, state) => transitionGoRoute(
              context: context,
              state: state,
              child: const SignInScreen(),
            ),
      ),
      GoRoute(
        path: Routes.kHomeScreen,
        pageBuilder:
            (context, state) => transitionGoRoute(
              context: context,
              state: state,
              child: const HomeScreen(),
            ),
      ),
      GoRoute(
        path: Routes.kBoardsScreen,
        pageBuilder: (context, state) {
          final int workspaceId = state.extra as int;
          return transitionGoRoute(
            context: context,
            state: state,
            child: AllBoards(workspaceId: workspaceId),
          );
        },
      ),
    ],
  );
}
