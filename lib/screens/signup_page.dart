import 'package:flutter/material.dart';
import 'package:pharmate/authorization/authorization.dart';
import 'package:pharmate/screens/favorite_pharmacy_page.dart';
import 'package:pharmate/widgets/login_text.dart';
import 'package:pharmate/widgets/rounded_text_field.dart';
import 'package:pharmate/widgets/signup_error_dialog.dart';

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
            RoundedTextField(
                controller: cfController,
                hintText: "Inserisci il tuo codice fiscale",
            ),
            const LoginText(text: "Nome"),
            RoundedTextField(
              controller: nameController,
              hintText: "Es. Mario Rossi",
            ),
            const LoginText(text: "Citta"),
            RoundedTextField(
              controller: cityController,
              hintText: 'Es. Bari',
            ),
            const LoginText(text: "Password"),
            RoundedTextField.obscured(
              controller: passwordController,
              hintText: 'Inserisci password',
            ),
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const FavoritePharmacyPage()));
                    } else {
                      showDialog(
                          context: context,
                          builder: ((context) {
                            return const SignupErrorDialog();
                          }));
                    }
                  });
                },
                icon: const Icon(Icons.navigate_next),
                label: const Text("Successivo"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
