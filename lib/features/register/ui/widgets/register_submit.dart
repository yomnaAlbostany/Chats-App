import 'package:chat_app/core/customs/custom_submit.dart';
import 'package:chat_app/core/extensions/extensions.dart';
import 'package:chat_app/core/routes/routes.dart';
import 'package:chat_app/features/register/logic/register_cubit.dart';
import 'package:chat_app/features/register/logic/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterSubmit extends StatelessWidget {
  const RegisterSubmit({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterErrorState) {
          final snackbar = SnackBar(
            content: Text(state.message),
            backgroundColor: Theme.of(context).colorScheme.primary,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        } else if (state is RegisterSuccessState) {
          final snackbar = SnackBar(
            content: Text('The register submit successfully'),
            backgroundColor: Theme.of(context).colorScheme.primary,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          context.pushReplacementNamed(Routes.createAccount);
        }
      },
      builder: (context, state) {
        if (state is RegisterLoadingState) {
          return CircularProgressIndicator();
        }
        return CustomSubmit(
          onTap: () {
            cubit.register();
          },
        );
      },
    );
  }
}
