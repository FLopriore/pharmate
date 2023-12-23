import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isObscured;
  final int textsLenght = 90;

  const RoundedTextField(
      {super.key, required this.controller, required this.hintText})
      : isObscured = false; 
      

  const RoundedTextField.obscured(
      {super.key, required this.controller, required this.hintText})
      : isObscured = true;
  
  const RoundedTextField.fixedText({super.key, required this.controller, required this.hintText,required textsLenght})
      : isObscured = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        obscureText: isObscured,
        maxLength:  textsLenght,
        decoration: InputDecoration(
          filled: true,
          border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(40))),
          hintText: hintText,
          counterText: "",
        ));
  }
}
