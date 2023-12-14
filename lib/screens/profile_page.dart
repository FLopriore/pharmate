import 'package:flutter/material.dart';
import 'package:pharmate/data/api.dart';
import 'package:pharmate/data/user_info.dart';
import 'package:pharmate/providers/accessibility_provider.dart';
import 'package:pharmate/screens/login_page.dart';
import 'package:pharmate/widgets/confirm_dialog_delete.dart';
import 'package:pharmate/widgets/confirm_dialog_logout.dart';
import 'package:pharmate/widgets/profile_text.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // TODO: elimina account
  Utente infos = Utente("", "", "", "");

  void _getInfo() async {
    var responseJson = await CallApi().getData("users/me");
    if (responseJson != null) {
      Utente inforesults = Utente.fromJson(responseJson);
      setState(() {
        infos = inforesults;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _getInfo();
      final bool accessibleNavigation =
        MediaQuery.of(context).accessibleNavigation;
    return Consumer(
        builder: (context, AccessibilityProvider themeNotifier, child) {
      return Scaffold(
          body: ListView(
        children: [
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
          const SizedBox(
            height: 100,
          ),
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
              children: <Widget>[
                const ExcludeSemantics(
                    child: ProfileText(
                        title: 'Fullname: ', textAlign: TextAlign.end)),
                Semantics(
                    label: "Il tuo nome è ${infos.name}",
                    child: ProfileText(
                        title: infos.name, textAlign: TextAlign.start)),
                const ExcludeSemantics(
                    child: ProfileText(
                        title: 'Città: ', textAlign: TextAlign.end)),
                Semantics(
                    label: "Abiti a ${infos.citta}",
                    child: ProfileText(
                        title: infos.citta, textAlign: TextAlign.start)),
                const ExcludeSemantics(
                    child: ProfileText(
                        title: 'Codice Fiscale: ', textAlign: TextAlign.end)),
                Semantics(
                    label: "Il tuo codice fiscale è ${infos.cf}",
                    child: ProfileText(
                        title: infos.cf, textAlign: TextAlign.start)),
              ],
            ),
          ),
          //the switch tile is useless for the semantics
          ExcludeSemantics(
            child: SwitchListTile.adaptive(
              title: Text(themeNotifier.isAccessibleFont
                  ? "Usa il font predefinito"
                  : "Usa un font accessibile"),
              value: themeNotifier.isAccessibleFont,
              onChanged: (bool value) {
                themeNotifier.isAccessibleFont = value;
              },
              secondary: const Icon(Icons.font_download_outlined),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Semantics(
            label: "Esci dal tuo account",
            button: true,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFCAE6FF),
                foregroundColor: const Color(0xFF023D74),
              ),
              onPressed: () {
                if (accessibleNavigation==true){
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                        (Route<dynamic> route) => false);
                }
                else {showDialog(context: context, builder: ((context) {
                  return const DialogConfirmLogOut();
                }));}
              },
              child: const Text("LogOut"),
            ),
          ),
          Semantics(
            label: "Elimina il tuo account Pharmate",
            button: true,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF023D74), 
                foregroundColor: const Color(0xFFCAE6FF),
              ),
              onPressed: () {
                if(accessibleNavigation==true){
                  //TODO Elimina account
                }
                else{showDialog(context: context, builder: ((context) {
                  return const DialogConfirmDelete();
                }));}
              },
              child: const Text("Elimina Account"),
            ),
          )
        ],
      ));
    });
  }
}
