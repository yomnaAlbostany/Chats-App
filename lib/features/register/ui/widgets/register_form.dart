import 'package:chat_app/core/custom/custom_formfeild.dart';
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
      padding: const EdgeInsets.all(25.0),
      child: Form(
        key: cubit.formKey,
        child: Column(
          spacing: 20,
          children: [
            CustomFormfeild(
              hintText: 'Email',
              controller: cubit.emailController,
              keyboardType: TextInputType.emailAddress,
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
                  hintText: 'Password',
                  controller: cubit.passwordController,
                  obscureText: cubit.hidePassword,
                  iconData:
                      cubit.hidePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
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
