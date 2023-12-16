import 'package:flutter/material.dart';
import 'package:pharmate/data/api.dart';
import 'package:pharmate/data/avail_medicine.dart';
import 'package:pharmate/data/medicine.dart';
import 'package:pharmate/data/pharmacy.dart';
import 'package:pharmate/data/user_info.dart';
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
  int maxQta = 0;
  List<Medicine> favoriteMedicinesList = [];

  // List where each element chooses if "Order" button is enabled.
  // If element == true, the item is available at the favorite pharmacy.
  // Otherwise, button is disabled.
  List<bool> _isAvailableList = [];

  @override
  void initState() {
    super.initState();
    _getFavoritePharmacy();
    _loadFavorite().then((value) => _checkAvailability());
  }

  // Loading favoriteMedicinesList stored value
  Future<void> _loadFavorite() async {
    List<Medicine> favList = await SharedPref().getFavoriteMedicines();
    setState(() {
      favoriteMedicinesList = favList;
    });
  }

  void _checkAvailability() async {
    List<bool> availList = [];
    for (int i = 0; i < favoriteMedicinesList.length; i++) {
      Medicine element = favoriteMedicinesList[i];
      var responseJson = await CallApi().getData("prodotti/avail/${element.codice_aic}");
      List<AvailMedicine> pharmacies = List<AvailMedicine>.from(
          responseJson!.map((model) => AvailMedicine.fromJson(model)));
      bool isAvailable = pharmacies.any((element) =>
          element.farmacia.codice_farmacia == _favoritePharmacy.codice_farmacia);
      availList.add(isAvailable);
    }
    setState(() {
      _isAvailableList = availList;
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
            bool activated = (_isAvailableList.isNotEmpty) ? _isAvailableList[index] : false;
            return BuyNowListTile.activation(
              title: favoriteMedicinesList[index].nome,
              isActivated: activated,
              leading: IconButton(
                icon: const Icon(Icons.delete_outline),
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
                          // TODO: get qta from DB
                          pharmacy: _favoritePharmacy,
                          maxAvailQuantity: 100000,
                        )));
              },
            );
          }),
    );
  }

  void _getFavoritePharmacy() async {
    var responseJson = await CallApi().getData("users/me");
    if (responseJson != null) {
      Utente userInfo = Utente.fromJson(responseJson);
      _favoritePharmacy = userInfo.favourite;
    }
  }
}
