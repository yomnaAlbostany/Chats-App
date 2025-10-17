import 'package:chat_app/core/customs/custom_button.dart';
import 'package:chat_app/core/extensions/extensions.dart';
import 'package:chat_app/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset('assets/svgs/rectangle2.svg'),
        Positioned(
          top: 50,
          right: 30,
          left: 23,
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    btnColor: Theme.of(context).colorScheme.onPrimary.withAlpha(230),
                    textColor: Theme.of(context).colorScheme.secondary,
                    text: 'Login',
                    onPressed: () {
                      context.pushReplacementNamed(Routes.login);
                    },
                  ),
                  Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Enter your\nemail',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}