import 'package:flutter/material.dart';
import 'package:pharmate/data/api.dart';
import 'package:pharmate/data/avail_medicine.dart';
import 'package:pharmate/data/medicine.dart';
import 'package:pharmate/json_useful_fields.dart';
import 'package:pharmate/screens/confirm_order_page.dart';
import 'package:pharmate/widgets/buy_now_list_tile.dart';

class SearchExpansionTile extends StatefulWidget {
  final Medicine medicine;
  final Widget leading;
  const SearchExpansionTile({super.key, required this.medicine, required this.leading});

  @override
  State<SearchExpansionTile> createState() => _SearchExpansionTileState();
}

class _SearchExpansionTileState extends State<SearchExpansionTile> {
  List<AvailMedicine> listPharma = [];

  @override
  Widget build(BuildContext context) {
    return Semantics(
        explicitChildNodes: true,
        child: ExpansionTile(
          shape: Border.all(color: Colors.transparent),
          title: Semantics(
            onTapHint:
            "Tocca per scegliere la farmacia dal quale ordinare",
            child: Text(
              widget.medicine.nome,
              semanticsLabel: "Ordina ${widget.medicine.nome}",
            ),
          ),
          leading: widget.leading,
          onExpansionChanged: (value) {
            if (value) {
              _searchPharmacies(widget.medicine.codice_aic);
            } else {
              setState(() {
                listPharma = [];
              });
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
                            item: widget.medicine,
                            pharmacy: i.farmacia,
                            maxAvailQuantity: i.quantita,
                          )));
                    },
                  )),
          ],
        ));
  }

  void _searchPharmacies(String codiceAic) async {
    var responseJson = await CallApi().getData("prodotti/avail/$codiceAic");
    if (responseJson != null) {
      var modResponseJson = JsonUsefulFields.getAvailPharmaciesWithQta(responseJson);
      List<AvailMedicine> pharmacies = List<AvailMedicine>.from(
          modResponseJson.map((model) => AvailMedicine.fromJson(model)));
      setState(() {
        listPharma = pharmacies;
      });
    }
  }
}
