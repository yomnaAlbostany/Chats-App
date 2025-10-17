import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color btnColor;
  final Color textColor;
  double fontsize;
  double vpadding;
  double hpadding;
  double width;
  CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.btnColor,
    required this.textColor,
    this.fontsize = 16,
    this.vpadding = 10,
    this.hpadding = 15,
    this.width=80
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(vertical: vpadding, horizontal: hpadding),
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontsize,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
