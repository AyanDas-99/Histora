import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:histora/state/auth/bloc/auth_bloc.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.blue),
        ),
        onPressed: () {
          context.read<AuthBloc>().add(LoginWithGoogle());
        },
        child: BlocConsumer<AuthBloc, AuthState>(
          builder: (context, state) {
            return switch (state) {
              AuthStateLoggedIn() => const SizedBox(
                  height: 50,
                  width: 300,
                  child: Icon(
                    CupertinoIcons.check_mark,
                    color: Colors.green,
                  ),
                ),
              AuthStateLoggedOut() => const LoginBtn(),
              AuthStateUnknown() => const LoginBtn(),
              AuthStateLoading() => const SizedBox(
                  height: 50,
                  width: 300,
                  child: Center(child: CircularProgressIndicator(color: Colors.white)),
                ),
              AuthStateError() => const LoginBtn(),
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
                    content:
                        Text('Auth Error ${state.failure.message}')));
                break;
    
              default:
                break;
            }
          },
        ));
  }
}

class LoginBtn extends StatelessWidget {
  const LoginBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 300,
      height: 50,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Sign in with Google',
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
          SizedBox(width: 10),
          Icon(
            FontAwesomeIcons.google,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
