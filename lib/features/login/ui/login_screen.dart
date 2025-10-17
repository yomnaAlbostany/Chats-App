import 'package:chat_app/features/login/ui/widgets/login_form.dart';
import 'package:chat_app/features/login/ui/widgets/login_header.dart';
import 'package:chat_app/features/login/ui/widgets/login_submit.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        spacing: 20,
        children: [
          LoginHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  spacing: 10,
                  children: [
                    LoginForm(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: LoginSubmit()),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}