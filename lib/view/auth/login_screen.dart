import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:histora/state/auth/bloc/auth_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const String path = '/login';
  static const String name= 'login';
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: TextButton(
            onPressed: () {
              context.read<AuthBloc>().add(LoginWithGoogle());
            },
            child: BlocConsumer<AuthBloc, AuthState>(
              builder: (context, state) {
                return switch (state) {
                  AuthStateLoggedIn() => const Icon(
                      CupertinoIcons.check_mark,
                      color: Colors.green,
                    ),
                  AuthStateLoggedOut() => const Text('Google login'),
                  AuthStateUnknown() => const Text('Google login'),
                  AuthStateLoading() => const CircularProgressIndicator(),
                  AuthStateError() => const Text('Google login'),
                };
              },
              listener: (BuildContext context, AuthState state) {
                final messenger = ScaffoldMessenger.of(context);
                

                switch (state) {
                  case AuthStateUnknown():
                    messenger.showSnackBar(
                        const SnackBar(content: Text('Unknown auth state')));
                    break;
                  case AuthStateError():
                    messenger.showSnackBar(SnackBar(
                        content: Text('Auth Error ${state.failure.message}')));
                    break;

                  default:
                    break;
                }
              },
            )),
      ),
    );
  }
}
