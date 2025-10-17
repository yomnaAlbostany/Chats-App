import 'package:bloc/bloc.dart';
import 'package:chat_app/features/register/logic/register_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterIntialState());
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  register() async {
    if (formKey.currentState!.validate()) {
      emit(RegisterLoadingState());
      try {
        final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        emit(RegisterSuccessState(user));
      } on FirebaseAuthException catch (e) {
        emit(RegisterErrorState(e.message ?? e.toString()));
      }
    }
  }

  bool hidePassword = true;
  changeHidePassword() {
    hidePassword = !hidePassword;
    emit(RegisterHidePasswordState());
  }

  bool hideConfirmPassword = true;
  changeHideConfirmPassword() {
    hideConfirmPassword = !hideConfirmPassword;
    emit(RegisterHideConfirmPasswordState());
  }
}
