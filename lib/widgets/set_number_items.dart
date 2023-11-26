import 'package:flutter/material.dart';

class SetNumberItems extends StatefulWidget {
  final Function callBack; // necessary to get numItems on parent widget
  const SetNumberItems({super.key, required this.callBack});

  @override
  State<SetNumberItems> createState() => _SetNumberItemsState();
}

class _SetNumberItemsState extends State<SetNumberItems> {
  int numItems = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
            onPressed: (numItems == 1)
                ? null
                : () {
                    setState(() {
                      numItems--;
                      widget.callBack(numItems);
                    });
                  },
            icon: const Icon(Icons.remove_circle_outline)),
        Text(numItems.toString()),
        IconButton(
            onPressed: () {
              setState(() {
                numItems++;
                widget.callBack(numItems);
              });
            },
            icon: const Icon(Icons.add_circle_outline)),
      ],
    );
  }
}
