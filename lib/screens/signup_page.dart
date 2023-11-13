import 'package:flutter/material.dart';
import 'package:pharmate/widgets/bottom_nav_bar.dart';
import 'package:pharmate/widgets/login_text.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Align(
              alignment: Alignment.center,
              child: Text(
                "Registrati",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 50,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            const LoginText(text: "Email"),
            const TextField(
                decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  hintText: 'prova@email.com',
                )),
            const LoginText(text: "Password"),
            const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  hintText: 'Inserisci password',
                )),
            const LoginText(text: "Città di riferimento"),
            const TextField(
                decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  hintText: 'Es. Bari',
                )),
            const LoginText(text: "Farmacia di fiducia"),
            const TextField(
                decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  hintText: 'Es. Farmacia del Cambio',
                )),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff0888fd),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const BottomNavBar()));
                  // TODO: signup
                },
                icon: const Icon(Icons.login),
                label: const Text("Entra"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
