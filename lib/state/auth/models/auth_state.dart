// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart' show immutable;
import 'package:histora/state/auth/models/auth_result.dart';

@immutable
class AuthState {
  final AuthResult? authResult;
  final bool? isLoading;
  final String? userId;
  const AuthState({
    required this.authResult,
    required this.isLoading,
    required this.userId,
  });

  const AuthState.unknown()
      : authResult = null,
        isLoading = false,
        userId = null;

  AuthState copyWithLoading(bool value) =>
      AuthState(authResult: authResult, isLoading: value, userId: userId);

  @override
  bool operator ==(covariant AuthState other) =>
      authResult == other.authResult &&
      isLoading == other.isLoading &&
      userId == other.userId &&
      runtimeType == other.runtimeType;

  @override
  int get hashCode => Object.hashAll([authResult, isLoading, userId]);
}
