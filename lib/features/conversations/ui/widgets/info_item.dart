import 'package:chat_app/core/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InfoItem extends StatelessWidget {
  const InfoItem({
    super.key,
    required this.label,
    required this.content,
  });

  final String label;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColor.hintColor,
                ),
              ),
              Expanded(
                child: Text(
                  content,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF414141),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: content));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Copied to clipboard "),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                  );
                },
                icon: Icon(Icons.copy, color: const Color(0xFF414141)),
              ),
            ],
          );
  }
}
