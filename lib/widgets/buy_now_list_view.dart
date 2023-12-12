import 'package:flutter/material.dart';
import 'package:pharmate/screens/confirm_order_page.dart';
import 'package:pharmate/widgets/buy_now_list_tile.dart';
import 'package:pharmate/widgets/rounded_background_rectangle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuyNowListView extends StatefulWidget {
  const BuyNowListView({super.key});

  @override
  State<BuyNowListView> createState() => _BuyNowListViewState();
}

class _BuyNowListViewState extends State<BuyNowListView> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<String> favoriteMedicinesList = [];

  @override
  void initState() {
    super.initState();
    _loadFavorite();
  }

  // Loading favoriteMedicinesList stored value on start
  Future<void> _loadFavorite() async {
    final prefs = await _prefs;
    setState(() {
      favoriteMedicinesList = prefs.getStringList('favorite') ?? [];
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
            return BuyNowListTile(
              title: favoriteMedicinesList[index],
              leading: IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () async {
                  final prefs = await _prefs;
                  setState(() {
                    favoriteMedicinesList.removeAt(index); // remove medicine from favorite
                    prefs.setStringList('favorite', favoriteMedicinesList);
                  });
                },
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ConfirmOrderPage(
                          item: favoriteMedicinesList[index],
                          // TODO: get favorite pharmacy and qta from DB
                          pharmacy: "Farmacia del Cambio",
                          maxAvailQuantity: 100000,
                        )));
              },
            );
          }),
    );
  }
}
