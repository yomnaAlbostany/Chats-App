import 'package:chat_app/core/custom/custom_formfeild.dart';
import 'package:chat_app/features/create_user/logic/create_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateVserForm extends StatelessWidget {
  const CreateVserForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateUserCubit>();
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Form(
        key: cubit.formKey,
        child: Column(
          spacing: 20,
          children: [
            CustomFormfeild(
              hintText: 'Name',
              controller: cubit.nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
