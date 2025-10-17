import 'package:chat_app/core/customs/custom_formfeild.dart';
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
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: cubit.formKey,
        child: Column(
          spacing: 17,
          children: [
            CustomFormfeild(
              keyboardType: TextInputType.emailAddress,
              hintText: 'Enter your email',
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
                  obscure: cubit.hidePassword,
                  iconData:
                      cubit.hidePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                  onPressed: () {
                    cubit.changeHidePassword();
                  },
                  hintText: 'Enter your password',
                  controller: cubit.passwordController,
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
