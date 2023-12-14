import 'package:flutter/material.dart';
import 'package:pharmate/authorization/authorization.dart';
import 'package:pharmate/widgets/bottom_nav_bar.dart';
import 'package:pharmate/widgets/login_text.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController cfController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cityController = TextEditingController();

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
            const LoginText(text: "Codice Fiscale"),
            TextField(
                controller: cfController,
                decoration: const InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  hintText: 'Inserisci il tuo codice fiscale',
                )),
            const LoginText(text: "Nome"),
            TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  hintText: 'Es. Mario Rossi',
                )),
            const LoginText(text: "Citta"),
            TextField(
                controller: cityController,
                decoration: const InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  hintText: 'Es. Bari',
                )),
            const LoginText(text: "Password"),
            TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  hintText: 'Inserisci password',
                )),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff023D74),
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  await Authorization()
                      .signUp(nameController.text, passwordController.text,
                          cfController.text, cityController.text)
                      .then((bool success) {
                    if (success) {
                      // TODO: push to page to select favorite pharmacy
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const BottomNavBar()));
                    } // TODO: add dialog to show signup error
                  });
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
