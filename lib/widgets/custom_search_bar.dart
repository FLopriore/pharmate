import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pharmate/screens/my_orders.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20,top: 5,left: 20),
      child:SearchAnchor(
          builder: (BuildContext context, SearchController controller) {
        return SearchBar(
          controller: controller,
          hintText: "Cerca un Farmaco",
          padding: const MaterialStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 10.0)),
          onTap: () {
            controller.openView();
          },
          onChanged: (_) {
            controller.openView();
          },
          onSubmitted: (String str){
            Navigator.of(context).push(MaterialPageRoute(builder:(context) => const MyOrders()));
          },
          leading: const Icon(Icons.search),
        );
      }, suggestionsBuilder:
              (BuildContext context, SearchController controller) {
        return List<ListTile>.generate(3, (int index) {  // TODO: change size of list
          final String item = 'item $index';
          return ListTile(
            title: Text(item),
            onTap: () {
              setState(() {
                controller.closeView(item); // TODO: read medicines from db
              });
            },
          );
        });
      }),
    );
  }
}
