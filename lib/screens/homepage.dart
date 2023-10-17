import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
            "Benvenuto",
            style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 50),
            textAlign: TextAlign.center,
                ),
          ),
          //TODO: De-center the text
          SizedBox(height: 5),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Cerca un farmaco',
              filled: true,
            ),
          ),
          SizedBox(height: 75),
          Text(
            "Acquista di nuovo",
            style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 30),
            textAlign: TextAlign.left,
                ),
          Placeholder(), // TODO: add list of favorite medicines
        ],
      ),
    );
  }
}
