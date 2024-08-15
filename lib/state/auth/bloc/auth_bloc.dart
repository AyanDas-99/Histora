import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:histora/core/error/failure.dart';
import 'package:histora/state/auth/backend/authenticator.dart';
import 'package:histora/state/auth/models/auth_result.dart';
import 'dart:developer' as dev;

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Authenticator authenticator;

  AuthBloc(this.authenticator)
      : super(authenticator.currentUser == null
            ? AuthStateLoggedOut()
            : AuthStateLoggedIn(user: authenticator.currentUser!)) {
    on<LoginWithGoogle>(googleLogin);
    // on<Listen>(stateChange);
    on<Logout>(logout);
  }

  void googleLogin(AuthEvent event, Emitter emit) async {
    emit(AuthStateLoading());
    final result = await authenticator.loginWithGoogle();
    switch (result) {
      case AuthResult.success:
        final user = authenticator.currentUser;
        if (user == null) {
          emit(AuthStateError(failure: UserLoadingFailure()));
        } else {
          emit(AuthStateLoggedIn(user: user));
        }
        break;
      case AuthResult.failure:
        emit(const AuthStateError(failure: LoginFailure()));
        break;
      case AuthResult.aborted:
        emit(const AuthStateError(failure: LoginFailure()));
        break;
    }
  }

  // void stateChange(AuthEvent event, Emitter emit) async {
  //   authenticator.user.listen((user) {
  //     if (user == null) {
  //       emit(AuthStateLoggedOut());
  //     } else {
  //       emit(AuthStateLoggedIn(user: user));
  //     }
  //   });
  // }

  void logout(AuthEvent event, Emitter emit) async {
    emit(AuthStateLoading());
    await authenticator.logOut();
    emit(AuthStateLoggedOut());
  }

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    super.onTransition(transition);
    dev.log(transition.toString());
  }
}
