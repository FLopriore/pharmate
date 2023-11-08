import 'package:flutter/material.dart';

class SetNumberItems extends StatefulWidget {
  const SetNumberItems({super.key});

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
                    });
                  },
            icon: const Icon(Icons.remove_circle_outline)),
        Text(numItems.toString()),
        IconButton(
            onPressed: () {
              setState(() {
                numItems++;
              });
            },
            icon: const Icon(Icons.add_circle_outline)),
      ],
    );
  }
}
