import 'package:flutter/material.dart';
import 'package:pharmate/screens/login_page.dart';
import 'package:pharmate/screens/search_results_page.dart';
import 'package:pharmate/ui/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmate/providers/accessibility_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AccessibilityProvider(),
      child: Consumer(
        builder:(context, AccessibilityProvider themeNotifier, child){
          return MaterialApp(
            showSemanticsDebugger: true, //IMPOSTA A TRUE PER VEDERE LA SEMANTICA
            debugShowCheckedModeBanner: false,
            title: 'PharMate',
            theme: ThemeData(
                  useMaterial3: true,
                  colorScheme: lightColorScheme,
                  textTheme: themeNotifier.isAccessibleFont ? GoogleFonts.lexendDecaTextTheme() : GoogleFonts.interTightTextTheme(),
            ),
            home: const SearchResultsPage(),
          );
        }
      ),
      );
  }
}