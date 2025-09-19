import 'package:chat_app/features/register/logic/register_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterIntialState());

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool hidePassword = true;
  void changeHidePassword() {
    hidePassword = !hidePassword;
    emit(RegisterHidePasswordState());
  }

  void register() async {
    if (formKey.currentState!.validate()) {
      emit(RegisterLoadingState());
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        emit(RegisterSuccessState());
      } on FirebaseAuthException catch (e) {
        emit(RegisterErrorState(e.message ?? e.toString()));
      }
    }
  }
}
