import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginState {}

final class LoginIntialState extends LoginState {}

final class LoginLoadingState extends LoginState {}

final class LoginErrorState extends LoginState {
  final String message;

  LoginErrorState(this.message);
}

final class LoginSuccessState extends LoginState {
  final UserCredential userCredential;

  LoginSuccessState(this.userCredential);
}

final class LoginHidePasswordState extends LoginState {
  bool hide;
  LoginHidePasswordState(this.hide);
}
