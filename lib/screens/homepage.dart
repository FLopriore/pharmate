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
          SizedBox(width: 450,
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
            "Benvenuto",
            style: const TextStyle(fontWeight: FontWeight.w900,fontSize: 50,color: Colors.black),
            textAlign: TextAlign.center,
                ),
          ),),
          //TODO: De-center the text
          SizedBox(width: 450,
            child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                Radius.circular(60.0), 
                ),
                borderSide: BorderSide(
                width: 0, 
                style: BorderStyle.none,
                  )
                  ),
              hintText: 'Cerca un farmaco',
              suffixIcon: Icon(Icons.search),
              filled: true,
            ),
          ),

          ),
          SizedBox(height: 75),
          Text(
            "Acquista subito",
            style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 30),
            textAlign: TextAlign.left,
                ),
          Placeholder(), // TODO: add list of favorite medicines
        ],
      ),
    );
  }
}
