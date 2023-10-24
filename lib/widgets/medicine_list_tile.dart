import 'package:flutter/material.dart';

class MedicineListTile extends StatelessWidget {
  final String title;
  final Widget? leading;

  const MedicineListTile({super.key, required this.title, this.leading});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(title),
        leading: leading,
        trailing: ElevatedButton.icon(
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(Color(0xCAE6FFFF)),
            //foregroundColor: MaterialStatePropertyAll<Color>(Color(0xff0888FD)) // TODO (?): maybe change text color
          ),
          onPressed: () {},
          icon: const Icon(Icons.shopping_cart_outlined),
          label: const Text("Ordina"),
        ));
  }
}
