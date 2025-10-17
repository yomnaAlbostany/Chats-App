import 'package:chat_app/core/customs/custom_formfeild.dart';
import 'package:chat_app/features/create_account/logic/create_account_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAccountForm extends StatelessWidget {
  const CreateAccountForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateAccountCubit>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: cubit.formKey,
        child: Column(
          spacing: 17,
          children: [
            CustomFormfeild(
              hintText: 'Enter your name',
              controller: cubit.nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            CustomFormfeild(
              prefix: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${generateFlag()} (+20)',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              hintText: 'Enter your phone',
              controller: cubit.phoneController,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone';
                }
                return null;
              }
            ),
          ],
        ),
      ),
    );
  }

  String generateFlag() {
    String countryCode = 'eg';
    return countryCode.toUpperCase().replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397),
    );
  }
}
