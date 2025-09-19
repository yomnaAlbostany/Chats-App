import 'package:chat_app/features/create_user/ui/widgets/create_user_header.dart';
import 'package:chat_app/features/create_user/ui/widgets/create_vser_form.dart';
import 'package:chat_app/features/create_user/ui/widgets/submit_btn.dart';
import 'package:flutter/material.dart';

class CreateUser extends StatelessWidget {
  const CreateUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          spacing: 15,
          children: [
            CreateUserHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CreateVserForm(),
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