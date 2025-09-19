import 'package:chat_app/core/custom/custom_formfeild.dart';
import 'package:chat_app/features/login/logic/login_cubit.dart';
import 'package:chat_app/features/login/logic/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Form(
        key: cubit.formKey,
        child: Column(
          spacing: 20,
          children: [
            CustomFormfeild(
              hintText: 'Email',
              keyboardType: TextInputType.emailAddress,
              controller: cubit.emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                return CustomFormfeild(
                  hintText: 'Password',
                  controller: cubit.passwordController,
                  obscureText: cubit.hidePassword,
                  iconData:cubit.hidePassword? Icons.visibility:Icons.visibility_off,
                  onPressed: () {
                    cubit.changeHidePassword();
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
