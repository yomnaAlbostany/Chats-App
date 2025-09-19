import 'package:chat_app/features/login/logic/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginIntialState());

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool hidePassword = true;
  changeHidePassword() {
    hidePassword = !hidePassword;
    emit(LoginHidePasswordState(hidePassword));
  }

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      emit(LoginLoadingState());
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
        emit(LoginSuccessState(credential));
      } on FirebaseAuthException catch (e) {
        emit(LoginErrorState(e.message ?? e.toString()));
      }
    }
  }
}
