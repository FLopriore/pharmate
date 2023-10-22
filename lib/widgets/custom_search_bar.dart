import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  // Decides whether or not to change page when you submit a text in the SearchBar
  final bool _withRoute;

  // The destination page when you submit a text.
  final Widget page;

  // Default constructor (normal SearchBar)
  const CustomSearchBar({super.key})
      : _withRoute = false,
        page = const Placeholder();

  // Custom constructor
  // When text is submitted, navigates to the specified page.
  const CustomSearchBar.withPageRoute({super.key, required this.page})
      : _withRoute = true;

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
          if (widget._withRoute == true) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => widget.page));
          }
        },
        leading: const Icon(Icons.search),
      ),
    );
  }
}
