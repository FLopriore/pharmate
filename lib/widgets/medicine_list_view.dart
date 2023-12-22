import 'package:flutter/material.dart';
import 'package:pharmate/data/api.dart';
import 'package:pharmate/data/medicine.dart';
import 'package:pharmate/local_storage/shared_pref.dart';
import 'package:pharmate/providers/search_provider.dart';
import 'package:pharmate/widgets/rounded_background_rectangle.dart';
import 'package:pharmate/widgets/search_expansion_tile.dart';
import 'package:provider/provider.dart';

class MedicineListView extends StatefulWidget {
  const MedicineListView({super.key});

  @override
  State<MedicineListView> createState() => _MedicineListViewState();
}

class _MedicineListViewState extends State<MedicineListView> {
  List<Medicine> searchResultsList = [];
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
      if (mounted) {  // prevents "setState() called after dispose()" error
        setState(() {
          searchResultsList = searchResults;
        });
      }
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

            return SearchExpansionTile(
              medicine: element,
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
                            _favList.remove(
                                element); // remove medicine from favorite
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
            );
          }),
    );
  }
}
