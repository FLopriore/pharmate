import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isObscured;

  const RoundedTextField(
      {super.key, required this.controller, required this.hintText})
      : isObscured = false;

  const RoundedTextField.obscured(
      {super.key, required this.controller, required this.hintText})
      : isObscured = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        obscureText: isObscured,
        decoration: InputDecoration(
          filled: true,
          border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(40))),
          hintText: hintText,
        ));
  }
}
