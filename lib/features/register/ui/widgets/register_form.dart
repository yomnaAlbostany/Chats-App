import 'package:chat_app/core/customs/custom_formfeild.dart';
import 'package:chat_app/features/register/logic/register_cubit.dart';
import 'package:chat_app/features/register/logic/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();
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
            BlocBuilder<RegisterCubit, RegisterState>(
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
            BlocBuilder<RegisterCubit, RegisterState>(
              builder: (context, state) {
                return CustomFormfeild(
                  obscure: cubit.hideConfirmPassword,
                  iconData:
                      cubit.hideConfirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                  onPressed: () {
                    cubit.changeHideConfirmPassword();
                  },
                  hintText: 'Enter your password confirmation',
                  controller: cubit.passwordConfirmController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password confirmation';
                    } else if (value != cubit.passwordController.text) {
                      return 'password do not match';
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
