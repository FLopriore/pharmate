import 'package:flutter/material.dart';
import 'package:pharmate/widgets/my_orders_data_table.dart';
import 'package:pharmate/widgets/rounded_background_rectangle.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30),
          Align(
            alignment: Alignment.center,
            child: Text(
              "I miei ordini",
              semanticsLabel: "Pagina per gestire gli ordini",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 50,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: RoundedBackgroundRectangle(child: MyOrdersDataTable()),
            ),
          )
        ],
      ),
    );
  }
}
