import 'package:chat_app/core/customs/custom_submit.dart';
import 'package:chat_app/core/extensions/extensions.dart';
import 'package:chat_app/core/routes/routes.dart';
import 'package:chat_app/features/login/logic/login_cubit.dart';
import 'package:chat_app/features/login/logic/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginSubmit extends StatelessWidget {
  const LoginSubmit({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          final snackbar = SnackBar(
            content: Text('The login submitted successfully'),
            backgroundColor: Theme.of(context).colorScheme.primary,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          context.pushReplacementNamed(Routes.conversations);
        } else if (state is LoginErrorState) {
          final snackbar = SnackBar(content: Text(state.message),backgroundColor: Theme.of(context).colorScheme.primary,);
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      },
      builder: (context, state) {
        if (state is LoginLoadingState) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          );
        }
        return CustomSubmit(
          onTap: () {
            cubit.login();
          },
        );
      },
    );
  }
}
