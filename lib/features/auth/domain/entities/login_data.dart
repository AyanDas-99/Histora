import 'package:equatable/equatable.dart';

class LoginData extends Equatable {
  final String uid;

  const LoginData({required this.uid});

  @override
  List<Object?> get props => [uid];
}
