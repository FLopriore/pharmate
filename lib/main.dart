import 'package:flutter/material.dart';
import 'package:pharmate/screens/login_page.dart';
import 'package:pharmate/ui/theme.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PharMate',
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
          textTheme: GoogleFonts.interTightTextTheme()),
      //darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      //home: const BottomNavBar(),
      home: const LoginPage(),
    );
  }
}
