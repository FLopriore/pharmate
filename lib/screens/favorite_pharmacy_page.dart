import 'package:flutter/material.dart';
import 'package:pharmate/data/api.dart';
import 'package:pharmate/data/pharmacy.dart';
import 'package:pharmate/widgets/bottom_nav_bar.dart';
import 'package:pharmate/widgets/pharmacy_list_view.dart';
import 'package:pharmate/widgets/rounded_background_rectangle.dart';

class FavoritePharmacyPage extends StatelessWidget {
  static Pharmacy _selectedPharmacy = Pharmacy("", "", "");
  const FavoritePharmacyPage({super.key});

  // Used to get value from child widget.
  // No state management package was used in order not to over-engineer.
  callBack(Pharmacy pharmacy) {
    _selectedPharmacy = pharmacy;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 25),
          const Align(
            alignment: Alignment.center,
            child: Text(
              "Farmacia di fiducia",
              semanticsLabel: "Pagina per aggiungere una farmacia di fiducia",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 50,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: RoundedBackgroundRectangle(
                  child: PharmacyListView(callBack: callBack)), //TODO: Add Semantic for every tile
            ),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff023D74),
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              var data = {"farmacia_preferita": _selectedPharmacy.toJson()};
              await CallApi().postData(data, "users/edit").then((result) {
                if (result != null) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const BottomNavBar()));
                }
              });
            },
            icon: const Icon(Icons.login),
            label: const Text("Entra"),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
