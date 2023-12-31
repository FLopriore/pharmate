import 'package:flutter/material.dart';
import 'package:pharmate/authorization/authorization.dart';
import 'package:pharmate/data/api.dart';
import 'package:pharmate/authorization/login_secure_storage.dart';
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
    String? token = await LoginSecureStorage.getLoginSecureStorage('loginToken');
    String? cf = await LoginSecureStorage.getLoginSecureStorage('cf');
    String? password = await LoginSecureStorage.getLoginSecureStorage('password');

    LoginType loginType = _loginType(token, cf, password);
    bool login = false;

    switch (loginType) {
      case LoginType.token:
        await CallApi().getData('users/me').then((value) {
          if (value != null) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const BottomNavBar()),
                    (Route<dynamic> route) => false);
            login = true;
          }
        });
        if (login) break; // if it did login with token, exit switch
        continue pwd; // if token is expired, try login with cf and password
      pwd:
      case LoginType.password:
        await Authorization().login(cf ?? "", password ?? "").then((value) {
          if (value) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const BottomNavBar()),
                    (Route<dynamic> route) => false);
          } else {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginPage()),
                    (Route<dynamic> route) => false);
          }
        });
      case LoginType.login:
        Future.delayed(
            const Duration(seconds: 1),
                () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginPage()),
                        (Route<dynamic> route) => false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox.shrink(),
    );
  }

  LoginType _loginType(String? token, String? cf, String? password) {
    if (token != null && token.isNotEmpty) return LoginType.token;
    if (cf != null && password != null && cf.isNotEmpty && password.isNotEmpty){
      return LoginType.password;
    }
    return LoginType.login;
  }
}

enum LoginType {
  token,
  password,
  login,
}
