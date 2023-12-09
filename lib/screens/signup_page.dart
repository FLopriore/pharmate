import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
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
  TextEditingController nameController = TextEditingController();
  TextEditingController cfController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isSignUpSuccessful = false;

  Future getFCMToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
  } //TODO: Send FCM Token to server

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
                onPressed: () {
                  _register();
                  if (_isSignUpSuccessful) {
                    // TODO: add page to add favorite pharmacy
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const BottomNavBar()));
                  }
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

  // Returns true if login was successful
  void _register() async {
    var data = {
      'fullname': nameController.text,
      'password': passwordController.text,
      'cf': cfController.text,
      // TODO: add Firebase token
    };

    var response = await CallApi().postData(data, 'auth/signup');
    if (response.statusCode == 200) {
      var responseJson = jsonDecode(await response.transform(utf8.decoder).join());

      // Store login data in secure storage
      const storage = FlutterSecureStorage();
      await storage.write(key: 'loginToken', value: responseJson['token']);
      // TODO: add Firebase token
      _isSignUpSuccessful = true;
    }
  }
}
