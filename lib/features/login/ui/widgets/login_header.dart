import 'package:chat_app/core/custom/custom_button.dart';
import 'package:chat_app/core/helpers/extensions.dart';
import 'package:chat_app/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset('assets/svgs/Rectangle.svg'),
        Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 24,
              top: 60,
              bottom: 20,
            ),
            child: Column(
              spacing: 15,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 32,
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    CustomButton(
                      text: 'Register',
                      onPressed: () {
                        context.pushReplacementNamed(Routes.register);
                      },
                    ),
                  ],
                ),
                Text(
                  'Enter your\nemail address',
                  style: TextStyle(
                    fontSize: 28,
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
