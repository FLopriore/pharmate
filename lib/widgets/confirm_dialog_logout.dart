import 'package:flutter/material.dart';
import 'package:pharmate/screens/login_page.dart';

class DialogConfirmLogOut extends StatefulWidget {
  const DialogConfirmLogOut({super.key});

  @override
  State<DialogConfirmLogOut> createState() => _DialogConfirmLogOutState();
}

class _DialogConfirmLogOutState extends State<DialogConfirmLogOut> {
  

  @override
  Widget build(BuildContext context) {
    
    return AlertDialog(
      title: const Text("LogOut",style:TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
      ),
      content: const Text("Sei sicuro di uscire dal profilo?",style:TextStyle(fontWeight: FontWeight.normal, fontSize: 15)),

      actions: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xff023D74),
            foregroundColor: Colors.white,
            fixedSize: const Size.fromHeight(55),
          ),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                        (Route<dynamic> route) => false);
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