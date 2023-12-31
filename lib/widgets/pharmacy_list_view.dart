import 'package:flutter/material.dart';
import 'package:pharmate/data/api.dart';
import 'package:pharmate/data/pharmacy.dart';
import 'package:pharmate/json_useful_fields.dart';
import 'package:pharmate/providers/fav_pharmacy_provider.dart';
import 'package:provider/provider.dart';

class PharmacyListView extends StatefulWidget {
  const PharmacyListView({super.key});

  @override
  State<PharmacyListView> createState() => _PharmacyListViewState();
}

class _PharmacyListViewState extends State<PharmacyListView> {
  List<Pharmacy> pharmaciesList = [];

  @override
  void initState() {
    super.initState();
    _getPharmacies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavPharmacyProvider>(
      builder: (context, provider, child) {
        return (pharmaciesList.isNotEmpty)
            ? ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          itemCount: pharmaciesList.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            bool isSelected = provider.favPharmacyCode == pharmaciesList[index].codice_farmacia;
            return ListTile(
              selected: isSelected,
              title: Text(pharmaciesList[index].nome,style: const TextStyle(fontSize: 17),),
              trailing: IconButton(
                icon: Icon((isSelected)
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked),
                onPressed: () {
                  // Select this pharmacy as favorite one
                  provider.setFavPharma(pharmaciesList[index].codice_farmacia);
                },
              ),
            );
          },
        )
            : const Center(child: Text('Nessuna farmacia trovata'));
      }
    );
  }

  void _getPharmacies() async {
    var responseJson = await CallApi().getData("farmacie/find");
    if (responseJson != null) {
      var modResponseJson = JsonUsefulFields.getMyCityPharmacies(responseJson);

      List<Pharmacy> pharmacies = List<Pharmacy>.from(
          modResponseJson.map((model) => Pharmacy.fromJson(model)));
      setState(() {
        pharmaciesList = pharmacies;
      });
    }
  }
}
