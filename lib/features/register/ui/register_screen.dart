import 'package:chat_app/features/register/ui/widgets/register_form.dart';
import 'package:chat_app/features/register/ui/widgets/register_header.dart';
import 'package:chat_app/features/register/ui/widgets/submit_btn.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          spacing: 15,
          children: [
            RegisterHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    RegisterForm(),
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