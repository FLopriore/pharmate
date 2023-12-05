import 'package:flutter/material.dart';
import 'package:pharmate/screens/confirm_order_page.dart';
import 'package:pharmate/widgets/buy_now_list_tile.dart';
import 'package:pharmate/widgets/rounded_background_rectangle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedicineListView extends StatefulWidget {
  const MedicineListView({super.key});

  @override
  State<MedicineListView> createState() => _MedicineListViewState();
}

class _MedicineListViewState extends State<MedicineListView> {

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final List<String> searchResultsList = ['Tachipirina', 'Ibuprofene', 'Paracetamolo', 'Cardioaspirin', 'Hello', 'hello', 'ciao', 'Hello', 'hello'];
  final List<String> listPharma = ['Farmacia Del Cambio', 'Farmacia Calia', 'Open Pharma']; //TODO: Replace with DB Pharmas
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

  @override
  Widget build(BuildContext context) {
    return RoundedBackgroundRectangle(
        child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: searchResultsList.length,
            itemBuilder: (BuildContext context, int index) {
              String element = searchResultsList.elementAt(index);
              bool isFavorite = _favList.contains(element); // check if the result is among favorite medicines

              return ExpansionTile(
                shape: Border.all(color: Colors.transparent),
                title: Semantics(onTapHint: "Tocca per scegliere la farmacia dal quale ordinare",child:Text(element,semanticsLabel: "Ordina $element",),),
                leading: IconButton(
                    icon: (isFavorite)
                        ? const Icon(Icons.grade)
                        : const Icon(Icons.grade_outlined),
                    onPressed: () async {
                      final prefs = await _prefs;
                      setState(() {
                        if (isFavorite) {
                          _favList.remove(element); // remove medicine from favorite
                        } else {
                          _favList.add(element); // add medicine to favorite
                        }
                        prefs.setStringList('favorite', _favList);
                      });
                    },
                    style: ButtonStyle(
                        iconColor: MaterialStateProperty.all(const Color(0xff023D74)))),
                children: [
                  for (var i in listPharma)
                    Semantics(
                      label: "Premi per ordinare dalla farmacia",
                      child:BuyNowListTile(
                      title: i.toString(),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ConfirmOrderPage(
                              item: element,
                              pharmacy: i.toString(),
                            )));
                      },
                    )
                      ),
                ], //TODO: add pharmas that have medicine
              );
            }),
    );
  }
}
