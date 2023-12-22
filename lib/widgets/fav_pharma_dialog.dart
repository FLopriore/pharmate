import 'package:flutter/material.dart';

class FavPharmaDialog extends StatelessWidget {
  const FavPharmaDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Errore",
        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
      ),
      content: const Text("Devi selezionare una farmacia di fiducia.",
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15)),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xffCAE6FF),
            foregroundColor: const Color(0xff023D74),
            fixedSize: const Size.fromHeight(55),
          ),
          child: const Text("OK"),
        ),
      ],
    );
  }
}
