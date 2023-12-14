import 'package:flutter/material.dart';
import 'package:pharmate/data/api.dart';
import 'package:pharmate/data/avail_medicine.dart';
import 'package:pharmate/data/medicine.dart';
import 'package:pharmate/providers/search_provider.dart';
import 'package:pharmate/screens/confirm_order_page.dart';
import 'package:pharmate/widgets/buy_now_list_tile.dart';
import 'package:pharmate/widgets/rounded_background_rectangle.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedicineListView extends StatefulWidget {
  const MedicineListView({super.key});

  @override
  State<MedicineListView> createState() => _MedicineListViewState();
}

class _MedicineListViewState extends State<MedicineListView> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<Medicine> searchResultsList = [];
  List<AvailMedicine> listPharma = [];
  List<String> _favList = [];

  @override
  void initState() {
    super.initState();
    _loadFavorite();
  }

  // Loading stored values of favorite medicines on start
  Future<void> _loadFavorite() async {
    final prefs = await _prefs;
    setState(() {
      _favList = prefs.getStringList('favorite') ?? [];
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
            String element = searchResultsList.elementAt(index).nome;
            bool isFavorite = _favList.contains(
                element); // check if the result is among favorite medicines

            return Semantics(
                explicitChildNodes: true,
                child: ExpansionTile(
                  shape: Border.all(color: Colors.transparent),
                  title: Semantics(
                    onTapHint:
                        "Tocca per scegliere la farmacia dal quale ordinare",
                    child: Text(
                      element,
                      semanticsLabel: "Ordina $element",
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
                            final prefs = await _prefs;
                            setState(() {
                              if (isFavorite) {
                                _favList.remove(
                                    element); // remove medicine from favorite
                              } else {
                                _favList
                                    .add(element); // add medicine to favorite
                              }
                              prefs.setStringList('favorite', _favList);
                            });
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
                            title: i.f.nome,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ConfirmOrderPage(
                                        item: element,
                                        pharmacy: i.f.nome,
                                        maxAvailQuantity: i.qt,
                                      )));
                            },
                          )),
                  ],
                ));
          }),
    );
  }
}
