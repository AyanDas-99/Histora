import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:histora/core/view/loader_page.dart';
import 'package:histora/depedency_injector.dart';
import 'package:histora/state/auth/bloc/auth_bloc.dart';
import 'package:histora/view/home/home_screen.dart';
import 'package:histora/view/onboarding/onboarding_screen.dart';
import 'package:histora/view/screen_controller.dart';

class AppRouter {
  GoRouter router = GoRouter(
    routes: [
      // Main screen
      GoRoute(
        path: ScreenController.path,
        name: ScreenController.name,
        pageBuilder: (context, state) =>
            const MaterialPage(child: ScreenController()),
      ),

      // Onboarding Screen
      GoRoute(
        path: OnboardingScreen.path,
        name: OnboardingScreen.name,
        pageBuilder: (context, state) =>
            const MaterialPage(child: OnboardingScreen()),
      ),
      // Loader screen
      GoRoute(
        path: LoaderPage.path,
        name: LoaderPage.name,
        pageBuilder: (context, state) =>
            const MaterialPage(child: LoaderPage()),
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
