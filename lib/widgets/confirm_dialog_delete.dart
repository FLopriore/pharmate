import 'package:flutter/material.dart';
import 'package:pharmate/authorization/login_secure_storage.dart';
import 'package:pharmate/data/api.dart';
import 'package:pharmate/screens/login_page.dart';

class DialogConfirmDelete extends StatefulWidget {
  const DialogConfirmDelete({super.key});

  @override
  State<DialogConfirmDelete> createState() => _DialogConfirmDeleteState();
}

class _DialogConfirmDeleteState extends State<DialogConfirmDelete> {
  Future<void> _deleteUser() async {
    await CallApi().deleteData("users/");
    LoginSecureStorage.deleteLoginSecureStorage();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Elimina Account",
        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
      ),
      content: const Text(
          "Sei sicuro di voler cancellare il tuo account Pharmate(operazione irreversibile)",
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15)),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xff023D74),
            foregroundColor: Colors.white,
            fixedSize: const Size.fromHeight(55),
          ),
          onPressed: () {
            _deleteUser().then((value) => Navigator.of(context)
                .pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (Route<dynamic> route) => false));
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
