import 'package:flutter/material.dart';
import 'package:pharmate/data/api.dart';
import 'package:pharmate/data/avail_medicine.dart';
import 'package:pharmate/data/medicine.dart';
import 'package:pharmate/local_storage/shared_pref.dart';
import 'package:pharmate/providers/search_provider.dart';
import 'package:pharmate/screens/confirm_order_page.dart';
import 'package:pharmate/widgets/buy_now_list_tile.dart';
import 'package:pharmate/widgets/rounded_background_rectangle.dart';
import 'package:provider/provider.dart';

class MedicineListView extends StatefulWidget {
  const MedicineListView({super.key});

  @override
  State<MedicineListView> createState() => _MedicineListViewState();
}

class _MedicineListViewState extends State<MedicineListView> {
  List<Medicine> searchResultsList = [];
  List<AvailMedicine> listPharma = [];
  List<Medicine> _favList = [];

  @override
  void initState() {
    super.initState();
    _loadFavorite();
  }

  // Loading favoriteMedicinesList stored value
  Future<void> _loadFavorite() async {
    List<Medicine> favList = await SharedPref().getFavoriteMedicines();
    setState(() {
      _favList = favList;
    });
  }

  void _searchMedicines(String searchText) async {
    var responseJson =
        await CallApi().getData("prodotti/search?nome=$searchText");
    if (responseJson != null) {
      List<Medicine> searchResults = List<Medicine>.from(
          responseJson.map((model) => Medicine.fromJson(model)));
      setState(() {
        searchResultsList = searchResults;
      });
    }
  }

  void _searchPharmacies(String codiceAic) async {
    var responseJson = await CallApi().getData("prodotti/avail/$codiceAic");
    if (responseJson != null) {
      List<AvailMedicine> pharmacies = List<AvailMedicine>.from(
          responseJson.map((model) => AvailMedicine.fromJson(model)));
      setState(() {
        listPharma = pharmacies;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String searchedText = context.watch<SearchProvider>().searchText;
    _searchMedicines(searchedText);
    return RoundedBackgroundRectangle(
      child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: searchResultsList.length,
          itemBuilder: (BuildContext context, int index) {
            Medicine element = searchResultsList.elementAt(index);
            bool isFavorite = _favList.contains(element); // check if the result is among favorite medicines

            return Semantics(
                explicitChildNodes: true,
                child: ExpansionTile(
                  shape: Border.all(color: Colors.transparent),
                  title: Semantics(
                    onTapHint:
                        "Tocca per scegliere la farmacia dal quale ordinare",
                    child: Text(
                      element.nome,
                      semanticsLabel: "Ordina ${element.nome}",
                    ),
                  ),
                  leading: Semantics(
                    label: "Aggiungi ai preferiti",
                    button: true,
                    container: true,
                    explicitChildNodes: true,
                    child: ExcludeSemantics(
                      child: IconButton(
                          icon: (isFavorite)
                              ? const Icon(Icons.grade)
                              : const Icon(Icons.grade_outlined),
                          onPressed: () async {
                            setState(() {
                              if (isFavorite) {
                                _favList.remove(element); // remove medicine from favorite
                              } else {
                                _favList.add(element); // add medicine to favorite
                              }
                            });
                            SharedPref().setFavoriteMedicines(_favList);
                          },
                          style: ButtonStyle(
                              iconColor: MaterialStateProperty.all(
                                  const Color(0xff023D74)))),
                    ),
                  ),
                  onExpansionChanged: (value) {
                    if (value) {
                      _searchPharmacies(
                          searchResultsList.elementAt(index).codice_aic);
                    }
                  },
                  children: [
                    for (var i in listPharma)
                      Semantics(
                          label: "Premi per ordinare dalla farmacia",
                          child: BuyNowListTile(
                            title: i.farmacia.nome,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ConfirmOrderPage(
                                        item: element,
                                        pharmacy: i.farmacia,
                                        maxAvailQuantity: i.quantita,
                                      )));
                            },
                          )),
                  ],
                ));
          }),
    );
  }
}
