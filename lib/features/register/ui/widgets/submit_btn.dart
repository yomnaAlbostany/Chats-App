import 'package:chat_app/core/helpers/extensions.dart';
import 'package:chat_app/core/routes/routes.dart';
import 'package:chat_app/core/style/app_color.dart';
import 'package:chat_app/features/register/logic/register_cubit.dart';
import 'package:chat_app/features/register/logic/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubmitBtn extends StatelessWidget {
  const SubmitBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterErrorState) {
          final snackBar = SnackBar(
            content: Text(state.message),
            backgroundColor: Theme.of(context).colorScheme.primary,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (state is RegisterSuccessState) {
          final snackBar = SnackBar(
            content: Text('You have registered successfully.'),
            backgroundColor: Theme.of(context).colorScheme.primary,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          context.pushReplacementNamed(Routes.createUser);
        }
      },
      builder: (context, state) {
        if (state is RegisterLoadingState) {
          return Align(
            alignment: Alignment.centerRight,
            child: CircularProgressIndicator(),
          );
        }
        return InkWell(
          onTap: () {
            cubit.register();
          },
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [AppColor.primaryColor, Color(0xFF40C4FF)],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
              ),
            ),
            child: const Icon(
              Icons.arrow_right_alt_sharp,
              color: Colors.white,
              size: 40,
            ),
          ),
        );
      },
    );
  }
}
