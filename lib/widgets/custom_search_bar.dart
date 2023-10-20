import 'package:flutter/material.dart';
import 'package:pharmate/screens/my_orders.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, top: 5, left: 20),
      child: SearchBar(
        controller: controller,
        hintText: "Cerca un farmaco da ordinare",
        padding: const MaterialStatePropertyAll<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 10.0)),
        onSubmitted: (String str) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const MyOrders()));
        },
        leading: const Icon(Icons.search),
      ),
    );
  }
}
