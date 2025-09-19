import 'package:chat_app/features/login/ui/widgets/login_form.dart';
import 'package:chat_app/features/login/ui/widgets/login_header.dart';
import 'package:chat_app/features/login/ui/widgets/submit_btn.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          spacing: 15,
          children: [
            LoginHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    LoginForm(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28.0),
                        child: SubmitBtn(),
                      )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}