import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:histora/state/auth/bloc/auth_bloc.dart';
import 'package:histora/view/profile/components/detailed_stat_pages.dart';
import 'package:histora/view/profile/components/extras_profile.dart';
import 'package:histora/view/profile/components/user_details.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is AuthStateLoggedIn) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  UserDetails(
                    user: state.user,
                  ),
                  SizedBox(height: 20),
                  DetailedStatPages(),
                  SizedBox(height: 20),
                  ExtrasProfile(),
                ],
              ),
            ),
          ),
        );
      } else {
        return Container();
      }
    });
  }
}

class ConsumerStatelessWidget {}
