import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  // Decides whether or not to change page when you submit a text in the SearchBar
  final bool route;

  // The destination page when you submit a text.
  final Widget page;

  const CustomSearchBar({super.key, required this.route, required this.page});

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
          if (widget.route == true) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => widget.page));
          }
        },
        leading: const Icon(Icons.search),
      ),
    );
  }
}
