import 'package:flutter/material.dart';
import 'package:pharmate/widgets/custom_search_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20),
          Align(
            alignment: 
            Alignment.center,
            child: Text(
            "Benvenuto",
            style: TextStyle(fontWeight: FontWeight.w900,fontSize: 45,color: Colors.black),
            textAlign: TextAlign.center,
                ),
          ),
          //TODO: De-center the text
          CustomSearchBar(),
          SizedBox(height: 75),
          Text(
            "Acquista subito",
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.black),
            textAlign: TextAlign.left,
                ),
          Placeholder(), // TODO: add list of favorite medicines
        ],
      ),
    );
  }
}
