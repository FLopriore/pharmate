import 'package:flutter/material.dart';
import 'package:pharmate/screens/order_page.dart';
import 'package:pharmate/widgets/buy_now_list_view.dart';
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
            alignment: Alignment.center,
            child: Text(
              "Cerca Farmaco",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 45,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          CustomSearchBar.withPageRoute(page: MyOrders()),
          SizedBox(height: 60),
          Text(
            "Acquista subito",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.black,
            ),
            textAlign: TextAlign.left,
          ),
          Expanded(child: BuyNowListView()),
          SizedBox(height: 60),
        ],
      ),
    );
  }
}
