import 'package:chat_app/core/customs/custom_submit.dart';
import 'package:chat_app/core/extensions/extensions.dart';
import 'package:chat_app/core/routes/routes.dart';
import 'package:chat_app/features/create_account/logic/create_account_cubit.dart';
import 'package:chat_app/features/create_account/logic/create_account_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAccountSubmit extends StatelessWidget {
  const CreateAccountSubmit({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateAccountCubit>();
    return BlocConsumer<CreateAccountCubit, CreateAccountState>(
      listener: (context, state) {
        if (state is CreateAccountErrorState) {
          final snackbar = SnackBar(
            content: Text(state.message),
            backgroundColor: Theme.of(context).colorScheme.primary,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        } else if (state is CreateAccountSuccessState) {
          final snackbar = SnackBar(
            content: Text('The register submit successfully'),
            backgroundColor: Theme.of(context).colorScheme.primary,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          context.pushReplacementNamed(Routes.login);
        }
        
      },
      builder: (context, state) {
        if (state is CreateAccountLoadingState) {
          return CircularProgressIndicator();
        }
        return CustomSubmit(
          onTap: () {
            cubit.createAccount();
          },
        );
      },
    );
  }
}
