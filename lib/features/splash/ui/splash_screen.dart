import 'package:chat_app/core/helpers/extensions.dart';
import 'package:chat_app/core/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 5)).then((_) {
      if (FirebaseAuth.instance.currentUser!=null) {
        context.pushNamedAndRemoveUntil(Routes.conversations);  
      }
      else{
        context.pushNamedAndRemoveUntil(Routes.login);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              left: 80,
              right: 80,
              child: SvgPicture.asset(
                'assets/svgs/logo.svg',
                width: 170,
                height: 170,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
