import 'package:chat_app/core/style/app_color.dart';
import 'package:flutter/material.dart';

class CustomFormfeild extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  TextInputType? keyboardType;
  String? Function(String?)? validator;
  VoidCallback? onPressed;
  IconData? iconData;
  bool obscure;
  Widget? prefix;
  CustomFormfeild({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.keyboardType,
    this.onPressed,
    this.iconData,
    this.obscure=false,
    this.prefix
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColor.hintColor,
          fontSize: 16
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.hintColor),
          borderRadius: BorderRadius.circular(17),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(17),
        ),
        suffixIcon: IconButton(onPressed: onPressed, icon: Icon(iconData)),
        prefixIcon: prefix,
        prefixIconConstraints: BoxConstraints()
      ),
    );
  }
}
