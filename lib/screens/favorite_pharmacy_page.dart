import 'package:flutter/material.dart';
import 'package:pharmate/authorization/authorization.dart';
import 'package:pharmate/dialogs/error_dialog.dart';
import 'package:pharmate/providers/fav_pharmacy_provider.dart';
import 'package:pharmate/widgets/bottom_nav_bar.dart';
import 'package:pharmate/widgets/pharmacy_list_view.dart';
import 'package:pharmate/widgets/rounded_background_rectangle.dart';
import 'package:provider/provider.dart';

class FavoritePharmacyPage extends StatelessWidget {
  const FavoritePharmacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 80),
          const Align(
            alignment: Alignment.center,
            child: Text(
              "Farmacia di fiducia",
              semanticsLabel: "Pagina per aggiungere una farmacia di fiducia",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 45,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: RoundedBackgroundRectangle(child: PharmacyListView()),
            ),
          ),
          const SizedBox(height: 10,),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff023D74),
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              var provider = Provider.of<FavPharmacyProvider>(context, listen: false);
              await Authorization()
                  .setFavoritePharmacy(provider.favPharmacyCode)
                  .then((result) {
                if (result) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const BottomNavBar()),
                      (Route<dynamic> route) => false);
                } else {
                  showDialog(
                      context: context,
                      builder: ((context) {
                        return const ErrorDialog(
                          title: "Errore",
                          content: "Devi selezionare una farmacia di fiducia.",
                        );
                      }));
                }
              });
            },
            icon: const Icon(Icons.login),
            label: const Text("Entra",
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 17),
                ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
