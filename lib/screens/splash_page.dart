import 'package:flutter/material.dart';
import 'package:pharmate/data/api.dart';
import 'package:pharmate/data/login_secure_storage.dart';
import 'package:pharmate/screens/login_page.dart';
import 'package:pharmate/widgets/bottom_nav_bar.dart';

// Blank screen to login automatically if there are any stored tokens.
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  void _checkLogin() async {
    // Check if there are any stored tokens.
    String? token =
        await LoginSecureStorage.getLoginSecureStorage('loginToken');
    if (token != null && token.isNotEmpty) {
      // Test if
      await CallApi().getData('users/me').then((value) {
        if (value != null) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const BottomNavBar()));
        }
      });
    } else {
      Future.delayed(
          const Duration(seconds: 1),
          () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const LoginPage())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox.shrink(),
    );
  }
}
