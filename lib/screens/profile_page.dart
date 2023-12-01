import 'package:flutter/material.dart';
import 'package:pharmate/providers/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});
  
  @override
  State<ProfilePage> createState() => _ProfilePageState();

}
class _ProfilePageState extends State<ProfilePage> {
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, DarkThemeProvider themeNotifier, child){
        return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: (){
            themeNotifier.darkTheme
                ? themeNotifier.darkTheme = false
                : themeNotifier.darkTheme = true;
          }, 
          child: Text(themeNotifier.darkTheme ? "Ritorna al Font Predefinito" : "Passa a Font Acessibile"), 
          )
        ]
        ),
    );
      }
      );
  }
}
