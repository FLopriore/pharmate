import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pharmate/providers/search_provider.dart';
import 'package:pharmate/screens/splash_page.dart';
import 'package:pharmate/ui/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmate/providers/accessibility_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.setAutoInitEnabled(true);

  // Request permissions necessary for the notifications.
  FirebaseMessaging fm = FirebaseMessaging.instance;
  fm.requestPermission();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AccessibilityProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
      ],
      child: Consumer(
          builder: (context, AccessibilityProvider themeNotifier, child) {
        return MaterialApp(
          showSemanticsDebugger: false, //IMPOSTA A TRUE PER VEDERE LA SEMANTICA
          debugShowCheckedModeBanner: false,
          title: 'PharMate',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightColorScheme,
            textTheme: themeNotifier.isAccessibleFont
                ? GoogleFonts.lexendDecaTextTheme()
                : GoogleFonts.interTightTextTheme(),
          ),
          home: const SplashPage(),
        );
      }),
    );
  }
}