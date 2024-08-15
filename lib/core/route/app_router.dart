import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:histora/core/view/loader_page.dart';
import 'package:histora/depedency_injector.dart';
import 'package:histora/state/auth/bloc/auth_bloc.dart';
import 'package:histora/view/auth/login_screen.dart';
import 'package:histora/view/home/home_screen.dart';

class AppRouter {
  GoRouter router = GoRouter(
    routes: [
      // Home
      GoRoute(
        path: HomeScreen.path,
        name: HomeScreen.name,
        pageBuilder: (context, state) {
          return const MaterialPage(child: HomeScreen());
        },
      ),

      // Login screen
      GoRoute(
        path: LoginScreen.path,
        name: LoginScreen.name,
        pageBuilder: (context, state) =>
            const MaterialPage(child: LoginScreen()),
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
          sl<AppRouter>().router.namedLocation(HomeScreen.name),
        AuthStateLoggedOut() =>
          sl<AppRouter>().router.namedLocation(LoginScreen.name),
        AuthStateUnknown() =>
          sl<AppRouter>().router.namedLocation(LoaderPage.name),
        AuthStateLoading() => null,
        AuthStateError() => null,
      };
    },
  );
}
