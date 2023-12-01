import 'package:flutter/material.dart';
import 'package:pharmate/screens/login_page.dart';
import 'package:pharmate/ui/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmate/providers/dark_theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DarkThemeProvider(),
      child: Consumer(
        builder:(context, DarkThemeProvider themeNotifier, child){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'PharMate',
            theme: ThemeData(
                  useMaterial3: true,
                  colorScheme: lightColorScheme,
                  textTheme: themeNotifier.darkTheme ? GoogleFonts.lexendDecaTextTheme() : GoogleFonts.interTightTextTheme(),
            ),
            home: LoginPage(),
          );
        }
      ),
      );
  }
}