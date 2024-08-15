import 'dart:async';
import 'package:flutter/foundation.dart' show immutable;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:histora/state/auth/models/auth_result.dart';
import 'dart:developer' as dev;

@immutable
class Authenticator {
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;

  const Authenticator({required this.auth, required this.googleSignIn});

  String? get userId => auth.currentUser?.uid;

  String get displayName => auth.currentUser?.displayName ?? '';

  String? get email => auth.currentUser?.email;

  String? get photoUrl => auth.currentUser?.photoURL;

  bool get isLoggedIn => userId != null;

  User? get currentUser => auth.currentUser;

  // user stream
  Stream<User?> get user {
    return auth.authStateChanges();
  }

  // Google auth
  Future<AuthResult> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount == null) {
        return AuthResult.aborted;
      }
      final googleAuth = await googleSignInAccount.authentication;
      final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      try {
        await auth.signInWithCredential(credential);
        return AuthResult.success;
      } catch (e) {
        return AuthResult.failure;
      }
    } catch (e) {
      dev.log('Google login error', error: e);
      return AuthResult.failure;
    }
  }

  // Log out
  Future<void> logOut() async {
    await auth.signOut();
    await googleSignIn.signOut();
  }
}
