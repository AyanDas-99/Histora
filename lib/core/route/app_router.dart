import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:histora/core/view/loader_page.dart';
import 'package:histora/depedency_injector.dart';
import 'package:histora/state/auth/bloc/auth_bloc.dart';
import 'package:histora/state/structure/models/structure.dart';
import 'package:histora/view/history/history_screen.dart';
import 'package:histora/view/onboarding/onboarding_screen.dart';
import 'package:histora/view/screen_controller.dart';

class AppRouter {
  GoRouter router = GoRouter(
    routes: [
      // Main screen
      GoRoute(
        path: ScreenController.path,
        name: ScreenController.name,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const ScreenController(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ),
      ),

      // Onboarding Screen
       GoRoute(
        path: OnboardingScreen.path,
        name: OnboardingScreen.name,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const OnboardingScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ),
      ),
      // Loader screen
      GoRoute(
        path: LoaderPage.path,
        name: LoaderPage.name,
        pageBuilder: (context, state) =>
            const MaterialPage(child: LoaderPage()),
      ),
      // Loader screen
      GoRoute(
        path: HistoryScreen.path,
        name: HistoryScreen.name,
        pageBuilder: (context, state) {
          final Structure structure = state.extra as Structure;
          return MaterialPage(child: HistoryScreen(structure: structure));
        },
      ),
    ],
    redirect: (context, state) {
      final authState = context.read<AuthBloc>().state;
      return switch (authState) {
        AuthStateLoggedIn() =>
          sl<AppRouter>().router.namedLocation(ScreenController.name),
        AuthStateLoggedOut() =>
          sl<AppRouter>().router.namedLocation(OnboardingScreen.name),
        AuthStateUnknown() =>
          sl<AppRouter>().router.namedLocation(LoaderPage.name),
        AuthStateLoading() => null,
        AuthStateError() => null,
      };
    },
  );
}
