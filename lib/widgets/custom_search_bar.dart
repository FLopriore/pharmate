import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final bool route;
  final Widget page;
  const CustomSearchBar(this.route,this.page);

  bool get getRoute{return route;}
  Widget get getPage{return page;}

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState(this.page,this.route);
}
class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController controller = TextEditingController();
  final bool route;
  final Widget page;
  _CustomSearchBarState(this.page,this.route){}
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
          if (route == true){
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => page));
        }},
        leading: const Icon(Icons.search),
      ),
    );
  }
}
