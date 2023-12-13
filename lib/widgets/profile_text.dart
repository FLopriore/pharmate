import 'package:flutter/material.dart';

class ProfileText extends StatelessWidget {
  final String title;
  final TextAlign textAlign;
  const ProfileText({super.key, required this.title, required this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
      textAlign: textAlign,
    );
  }
}
