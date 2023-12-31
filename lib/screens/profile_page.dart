import 'package:flutter/material.dart';
import 'package:pharmate/authorization/login_secure_storage.dart';
import 'package:pharmate/data/api.dart';
import 'package:pharmate/data/pharmacy.dart';
import 'package:pharmate/data/user_info.dart';
import 'package:pharmate/json_useful_fields.dart';
import 'package:pharmate/providers/accessibility_provider.dart';
import 'package:pharmate/screens/favorite_pharmacy_page.dart';
import 'package:pharmate/screens/login_page.dart';
import 'package:pharmate/dialogs/confirm_dialog_delete.dart';
import 'package:pharmate/dialogs/confirm_dialog_logout.dart';
import 'package:pharmate/widgets/profile_text.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Utente> userInfo;

  @override
  void initState() {
    super.initState();
    userInfo = _getInfo();
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
          const SizedBox(height: 50,),
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
            child: FutureBuilder(
              future: userInfo,
              builder: (BuildContext context, AsyncSnapshot<Utente> snapshot) {
                if (snapshot.hasData) {
                  return GridView.count(
                    shrinkWrap: true,
                    primary: false,
                    crossAxisSpacing: 25,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3,
                    crossAxisCount: 2,
                    children: <Widget>[
                      const ExcludeSemantics(
                          child: ProfileText(
                              title: 'Nome: ', textAlign: TextAlign.end)),
                      Semantics(
                          label: "Il tuo nome è ${snapshot.data!.fullname}",
                          child: ProfileText(
                              title: snapshot.data!.fullname,
                              textAlign: TextAlign.start)),
                      const ExcludeSemantics(
                          child: ProfileText(
                              title: 'Città: ', textAlign: TextAlign.end)),
                      Semantics(
                          label: "Abiti a ${snapshot.data!.citta}",
                          child: ProfileText(
                              title: snapshot.data!.citta,
                              textAlign: TextAlign.start)),
                      const ExcludeSemantics(
                          child: ProfileText(
                              title: 'CF: ',
                              textAlign: TextAlign.end)),
                      Semantics(
                          label: "Il tuo codice fiscale è ${snapshot.data!.cf}",
                          child: ProfileText(
                              title: snapshot.data!.cf,
                              textAlign: TextAlign.start)),
                    ],
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
          //the switch tile is useless for the semantics
          ExcludeSemantics(
            child: SwitchListTile.adaptive(
              title: Text(themeNotifier.isAccessibleFont
                  ? "Usa il font predefinito"
                  : "Usa un font accessibile",
                  style: const TextStyle(fontSize: 20),),
              value: themeNotifier.isAccessibleFont,
              onChanged: (bool value) {
                themeNotifier.isAccessibleFont = value;
              },
              secondary: const Icon(Icons.font_download_outlined),
            ),
          ),
          const SizedBox(height: 20),
          Semantics(
            label: "Modifica la tua farmacia di fiducia",
            button: true,
            child: ExcludeSemantics(child:Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child:ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFCAE6FF),
                foregroundColor: const Color(0xFF023D74),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const FavoritePharmacyPage()));
              },
              child: const Text("Modifica farmacia di fiducia", style:TextStyle(fontSize: 17),),
            ),
          ),),),
          const SizedBox(height: 10),
          Semantics(
            label: "Esci dal tuo account",
            button: true,
            child: ExcludeSemantics(child:Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child:ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFCAE6FF),
                foregroundColor: const Color(0xFF023D74),
              ),
              onPressed: () {
                if (accessibleNavigation == true) {
                  LoginSecureStorage.deleteLoginSecureStorage();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                      (Route<dynamic> route) => false);
                } else {
                  showDialog(
                      context: context,
                      builder: ((context) {
                        return const DialogConfirmLogOut();
                      }));
                }
              },
              child: const Text("Esci dal profilo", style:TextStyle(fontSize: 17),),
            ),),
          ),),
          Semantics(
            label: "Elimina il tuo account Pharmate",
            button: true,
            child: ExcludeSemantics(child:Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child:ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF023D74),
                foregroundColor: const Color(0xFFCAE6FF),
              ),
              onPressed: () {
                if (accessibleNavigation == true) {
                  _deleteUser();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                      (Route<dynamic> route) => false);
                } else {
                  showDialog(
                      context: context,
                      builder: ((context) {
                        return const DialogConfirmDelete();
                      }));
                }
              },
              child: const Text("Elimina Account", style:TextStyle(fontSize: 17),),
            ),),
          )),
        ],
      ));
    });
  }

  Future<Utente> _getInfo() async {
    var responseJson = await CallApi().getData("users/me");
    Utente infoResults;
    if (responseJson != null) {
      var modResponseJson = JsonUsefulFields.getUserFields(responseJson);
      infoResults = Utente.fromJson(modResponseJson);
    } else {
      infoResults = Utente("", "", "", Pharmacy("", "", ""));
    }
    return infoResults;
  }

  Future<void> _deleteUser() async {
    bool deleteSuccess = await CallApi().deleteData("users/");
    if (deleteSuccess) LoginSecureStorage.deleteLoginSecureStorage();
  }
}
