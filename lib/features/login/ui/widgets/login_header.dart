import 'package:chat_app/core/customs/custom_button.dart';
import 'package:chat_app/core/extensions/extensions.dart';
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
        Positioned(
          top: 50,
          right: 25,
          left: 30,
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  CustomButton(
                    btnColor: Theme.of(context).colorScheme.onPrimary.withAlpha(230),
                    textColor: Theme.of(context).colorScheme.secondary,
                    text: 'Register',
                    width: 95,
                    onPressed: () {
                      context.pushReplacementNamed(Routes.register);
                    },
                  ),
                ],
              ),
              Text(
                'Enter your\nEmail',
                style: TextStyle(
                  fontSize: 29,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
