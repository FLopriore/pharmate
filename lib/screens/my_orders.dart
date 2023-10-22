import 'package:flutter/material.dart';
import 'package:pharmate/widgets/custom_search_bar.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100),
          Align(
            alignment: 
            Alignment.center,
            child: Text(
            "Ordina",
            style: TextStyle(fontWeight: FontWeight.w900,fontSize: 60,color: Colors.black),
            textAlign: TextAlign.center,
                ),
          ),
          CustomSearchBar(),
          SizedBox(height: 50),
          Placeholder(),
        ]
      )
      );
  }
}
