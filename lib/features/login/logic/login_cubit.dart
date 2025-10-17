import 'package:bloc/bloc.dart';
import 'package:chat_app/features/login/logic/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginIntialState());
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  login() async {
    if (formKey.currentState!.validate()) {
      emit(LoginLoadingState());
      try {
        final userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
        emit(LoginSuccessState(userCredential));
      } on FirebaseAuthException catch (e) {
        emit(LoginErrorState(e.message ?? e.toString()));
      }
    }
  }

  bool hidePassword = true;
  changeHidePassword() {
    hidePassword = !hidePassword;
    emit(LoginHidePasswordState());
  }
}
