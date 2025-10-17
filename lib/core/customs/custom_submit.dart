import 'package:flutter/material.dart';

class CustomSubmit extends StatelessWidget {
  final VoidCallback onTap;
  const CustomSubmit({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap ,
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primary.withAlpha(180),
            ],
          ),
        ),
        child: Icon(
          Icons.arrow_forward_ios,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
