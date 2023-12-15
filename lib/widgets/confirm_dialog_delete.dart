import 'package:flutter/material.dart';

class DialogConfirmDelete extends StatefulWidget {
  const DialogConfirmDelete({super.key});

  @override
  State<DialogConfirmDelete> createState() => _DialogConfirmDeleteState();
}

class _DialogConfirmDeleteState extends State<DialogConfirmDelete> {
  

  @override
  Widget build(BuildContext context) {
    
    return AlertDialog(
      title: const Text("Elimina Account",style:TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
      ),
      content: const Text("Sei sicuro di voler cancellare il tuo account Pharmate(operazione irreversibile)",style:TextStyle(fontWeight: FontWeight.normal, fontSize: 15)),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xff023D74),
            foregroundColor: Colors.white,
            fixedSize: const Size.fromHeight(55),
          ),
          onPressed: () {
            //TODO: Delete user from server
          },
          child: const Text("Conferma"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xffCAE6FF),
            foregroundColor: const Color(0xff023D74),
            fixedSize: const Size.fromHeight(55),
          ),
          child: const Text("Annulla"),
        ),
      ],

    );
  }
}