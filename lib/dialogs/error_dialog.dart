import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String title;
  final String content;
  const ErrorDialog({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
      ),
      content: Text(
          content,
          style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xffCAE6FF),
            foregroundColor: const Color(0xff023D74),
            fixedSize: const Size.fromHeight(55),
          ),
          child: const Text("OK"),
        ),
      ],
    );
  }
}
