import 'package:firebase_auth/firebase_auth.dart';

abstract class RegisterState {}

final class RegisterIntialState extends RegisterState {}

final class RegisterLoadingState extends RegisterState {}

final class RegisterErrorState extends RegisterState {
  final String message;

  RegisterErrorState(this.message);
}

final class RegisterSuccessState extends RegisterState {
  final UserCredential userCredential;

  RegisterSuccessState(this.userCredential);
}

final class RegisterHidePasswordState extends RegisterState {}

final class RegisterHideConfirmPasswordState extends RegisterState {}
