import 'package:flutter/material.dart';
import 'package:pharmate/data/api.dart';
import 'package:pharmate/data/avail_medicine.dart';
import 'package:pharmate/data/medicine.dart';
import 'package:pharmate/data/pharmacy.dart';
import 'package:pharmate/data/user_info.dart';
import 'package:pharmate/json_useful_fields.dart';
import 'package:pharmate/local_storage/shared_pref.dart';
import 'package:pharmate/screens/confirm_order_page.dart';
import 'package:pharmate/widgets/buy_now_list_tile.dart';
import 'package:pharmate/widgets/rounded_background_rectangle.dart';

class BuyNowListView extends StatefulWidget {
  const BuyNowListView({super.key});

  @override
  State<BuyNowListView> createState() => _BuyNowListViewState();
}

class _BuyNowListViewState extends State<BuyNowListView> {
  Pharmacy _favoritePharmacy = Pharmacy("", "", "");
  List<Medicine> favoriteMedicinesList = [];

  // List where each element chooses if "Order" button is enabled.
  // If element.quantita != 0, the item is available at the favorite pharmacy.
  // Otherwise, button is disabled.
  List<AvailMedicine> _availableList = [];

  @override
  void initState() {
    super.initState();
    _getFavoritePharmacy();
    _loadFavorite().then((value) => _checkAvailability());
  }

  // Loading favoriteMedicinesList stored value
  Future<void> _loadFavorite() async {
    List<Medicine> favList = await SharedPref().getFavoriteMedicines();

    // Check if the list is not empty to avoid useless reloading.
    if (favList.isNotEmpty) {
      setState(() {
        favoriteMedicinesList = favList;
      });
    }
  }

  void _checkAvailability() async {
    List<AvailMedicine> availList = [];
    for (int i = 0; i < favoriteMedicinesList.length; i++) {
      Medicine element = favoriteMedicinesList[i];
      var responseJson =
          await CallApi().getData("prodotti/avail/${element.codice_aic}");
      if (responseJson != null) {
        var modResponseJson = JsonUsefulFields.getAvailMedicineFavPharma(responseJson);
        AvailMedicine availMedicine = AvailMedicine.fromJson(modResponseJson);
        availList.add(availMedicine);
      } else {
        AvailMedicine availMedicine = AvailMedicine(Pharmacy("", "", ""), 0);
        availList.add(availMedicine);
      }
    }
    setState(() {
      _availableList = availList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RoundedBackgroundRectangle(
      child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          scrollDirection: Axis.vertical,
          itemCount: favoriteMedicinesList.length,
          itemBuilder: (BuildContext context, int index) {
            // Check if _availableList loaded.
            // Otherwise, disable all the buttons by default.
            bool activated = (_availableList.isNotEmpty)
                ? (_availableList[index].quantita != 0)
                : false;

            return BuyNowListTile.activation(
              title: favoriteMedicinesList[index].nome,
              isActivated: activated,
              leading: IconButton(
                icon: const Icon(Icons.delete_outline,semanticLabel: "Elimina Farmaco dai Preferiti",),
                onPressed: () async {
                  setState(() {
                    favoriteMedicinesList
                        .removeAt(index); // remove medicine from favorite
                  });
                  SharedPref().setFavoriteMedicines(favoriteMedicinesList);
                },
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ConfirmOrderPage(
                          item: favoriteMedicinesList[index],
                          pharmacy: _favoritePharmacy,
                          maxAvailQuantity: _availableList[index].quantita,
                        )));
              },
            );
          }),
    );
  }

  void _getFavoritePharmacy() async {
    var responseJson = await CallApi().getData("users/me");
    if (responseJson != null) {
      var modResponseJson = JsonUsefulFields.getUserFields(responseJson);
      Utente userInfo = Utente.fromJson(modResponseJson);
      _favoritePharmacy = userInfo.favourite;
    }
  }
}
