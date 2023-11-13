import 'package:flutter/material.dart';
import 'package:pharmate/screens/signup_page.dart';
import 'package:pharmate/widgets/bottom_nav_bar.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Accedi",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 50,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 50),
              const TextField(
                  decoration: InputDecoration(
                filled: true,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                labelText: 'Email',
              )),
              const SizedBox(height: 16),
              const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    labelText: 'Password',
                  )),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff0888fd),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const BottomNavBar()));
                    // TODO: login
                  },
                  icon: const Icon(Icons.login),
                  label: const Text("Entra"),
                ),
              ),
              const SizedBox(height: 80),
              const Text(
                "Primo accesso?",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFCAE6FF),
                  foregroundColor: const Color(0xFF0888FD),
                ),
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const SignUpPage())),
                child: const Text("Registrati"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
