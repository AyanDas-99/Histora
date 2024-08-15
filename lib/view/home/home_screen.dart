import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:histora/state/auth/bloc/auth_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static String get name => 'home';

  static String get path => '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthStateLoggedIn) {
                return Text('${state.user.uid} ${state.user.displayName}');
              } else {
                return Container();
              }
            },
          ),
          const SizedBox(height: 50),
          TextButton(
            onPressed: () {
              context.read<AuthBloc>().add(Logout());
            },
            child: const Text('Log out'),
          ),
          Text("hello world"),
          const SizedBox(height: 20),
          RichText(text: const TextSpan(text: '''
 <h1>Heading 1</h1>
 <h2>Heading 2</h1>
 <p> THis is a paragraph</p> 
''', style: TextStyle(color: Colors.black)))
        ],
      ),
    );
  }
}
