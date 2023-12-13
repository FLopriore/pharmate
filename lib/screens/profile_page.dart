import 'package:flutter/material.dart';
import 'package:pharmate/providers/accessibility_provider.dart';
import 'package:pharmate/widgets/profile_text.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, AccessibilityProvider themeNotifier, child) {
      return Scaffold(
          body: ListView(
        children: [
          SizedBox(
              width: 500,
              height: 250,
              child: GridView.count(
                shrinkWrap: true,
                primary: false,
                crossAxisSpacing: 30,
                mainAxisSpacing: 10,
                childAspectRatio: 5,
                crossAxisCount: 2,
                children: const <Widget>[
                  ProfileText(title: 'Città: ', textAlign: TextAlign.end),
                  ProfileText(title: 'Bari', textAlign: TextAlign.start), // TODO: add data from DB
                  ProfileText(title: 'Codice Fiscale: ', textAlign: TextAlign.end),
                  ProfileText(title: 'N0NCH0S0RD1', textAlign: TextAlign.start), // TODO: add data from DB
                ],
              ),
            ),
          const Text(
            "Profilo",
            semanticsLabel: "Pagina Profilo",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 50,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          //the switch tile is useless for the semantics
          ExcludeSemantics(child: SwitchListTile.adaptive(
            title: Text(themeNotifier.isAccessibleFont
                ? "Usa il font predefinito"
                : "Usa un font accessibile"),
            value: themeNotifier.isAccessibleFont,
            onChanged: (bool value) {
              themeNotifier.isAccessibleFont = value;
            },
            secondary: const Icon(Icons.font_download_outlined),
          ),)
        ],
      ));
    });
  }
}
