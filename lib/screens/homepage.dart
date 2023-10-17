import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Text("Benvenuto"), // TODO: increase text style
          // TODO: increase space between the widgets
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Cerca un farmaco',
              filled: true,
            ),
          ),
          Placeholder(), // TODO: add list of favorite medicines
        ],
      ),
    );
  }
}
