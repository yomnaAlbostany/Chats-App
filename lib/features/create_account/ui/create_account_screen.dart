import 'package:chat_app/features/create_account/ui/widgets/create_account_form.dart';
import 'package:chat_app/features/create_account/ui/widgets/create_account_header.dart';
import 'package:chat_app/features/create_account/ui/widgets/create_account_submit.dart';
import 'package:flutter/material.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        spacing: 20, 
        children: [
          CreateAccountHeader(), 
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 10,
                  children: [
                    CreateAccountForm(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: CreateAccountSubmit()),
                    ),
                  ],
                ),
              ),
            ),
          )
          ]
        ),
    );
  }
}
