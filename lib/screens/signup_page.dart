import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pharmate/data/api.dart';
import 'package:pharmate/widgets/bottom_nav_bar.dart';
import 'package:pharmate/widgets/login_text.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController pharmacyController = TextEditingController();

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
            TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  hintText: 'prova@email.com',
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
            const LoginText(text: "Città di riferimento"),
            TextField(
                controller: cityController,
                decoration: const InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  hintText: 'Es. Bari',
                )),
            const LoginText(text: "Farmacia di fiducia"),
            TextField(
                controller: pharmacyController,
                decoration: const InputDecoration(
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
                  backgroundColor: const Color(0xff023D74),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  _register();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const BottomNavBar()));
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

  void _register() async {
    var data = {
      'email': emailController.text,
      'password': passwordController.text,
      'city': cityController.text,
      'favoritePharmacy': pharmacyController.text,
    };
    // 'utenti' is the end-point
    var responseJson = await CallApi().postData(data, 'utenti');

    // Store login data in secure storage
    const storage = FlutterSecureStorage();
    await storage.write(key: 'email', value: responseJson['email']);
    await storage.write(key: 'password', value: responseJson['password']);
    await storage.write(key: 'city', value: responseJson['city']);
    await storage.write(key: 'pharmacy', value: responseJson['pharmacy']);
  }
}
