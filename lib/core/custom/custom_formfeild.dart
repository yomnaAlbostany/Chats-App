import 'package:chat_app/core/style/app_color.dart';
import 'package:flutter/material.dart';

class CustomFormfeild extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  String? Function(String?)? validator;
  final VoidCallback? onPressed;
  final IconData? iconData;
  bool obscureText;
  bool readOnly;
  final TextInputType? keyboardType;
  CustomFormfeild({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.onPressed,
    this.iconData,
    this.obscureText = false,
    this.readOnly=false,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: AppColor.hintColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColor.hintColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColor.hintColor),
        ),
        suffixIcon: IconButton(
          onPressed: onPressed,
          icon: Icon(iconData, color:AppColor.hintColor),
        ),
      ),
      validator: validator,
      obscureText: obscureText,
      readOnly: readOnly,
    );
  }
}
