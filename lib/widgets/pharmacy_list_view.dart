import 'package:flutter/material.dart';
import 'package:pharmate/data/api.dart';
import 'package:pharmate/data/pharmacy.dart';
import 'package:pharmate/json_useful_fields.dart';

class PharmacyListView extends StatefulWidget {
  final Function
      callBack; // necessary to get selected pharmacy on parent widget
  const PharmacyListView({super.key, required this.callBack});

  @override
  State<PharmacyListView> createState() => _PharmacyListViewState();
}

class _PharmacyListViewState extends State<PharmacyListView> {
  List<Pharmacy> pharmaciesList = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _getPharmacies();
  }

  @override
  Widget build(BuildContext context) {
    return (pharmaciesList.isNotEmpty)
        ? ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            itemCount: pharmaciesList.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                selected: index == _selectedIndex,
                title: Text(pharmaciesList[index].nome),
                trailing: IconButton(
                  icon: Icon((index == _selectedIndex)
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked),
                  onPressed: () {
                    // Select this pharmacy as favorite one
                    setState(() {
                      _selectedIndex = index;
                    });
                    widget.callBack(pharmaciesList[index]);
                  },
                ),
              );
            },
          )
        : const Center(child: Text('Nessuna farmacia trovata'));
  }

  void _getPharmacies() async {
    var responseJson = await CallApi().getData("farmacie/mycity");
    if (responseJson != null) {

      // TODO: remove this variable when server is complete
      var modresponseJson = JsonUsefulFields.getMyCityPharmacies(responseJson);

      List<Pharmacy> pharmacies = List<Pharmacy>.from(
          modresponseJson.map((model) => Pharmacy.fromJson(model)));
      setState(() {
        pharmaciesList = pharmacies;
      });
    }
  }
}
