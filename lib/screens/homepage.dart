import 'package:flutter/material.dart';
import 'package:pharmate/screens/my_orders.dart';
import 'package:pharmate/widgets/custom_search_bar.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  static bool route = true;
   Widget page = MyOrders();
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
            "Cerca Farmaco",
            style: TextStyle(fontWeight: FontWeight.w900,fontSize: 45,color: Colors.black),
            textAlign: TextAlign.center,
                ),
          ),
          CustomSearchBar(true,MyOrders()),
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
