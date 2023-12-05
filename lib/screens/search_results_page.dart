import 'package:flutter/material.dart';
import 'package:pharmate/widgets/custom_search_bar.dart';
import 'package:pharmate/widgets/medicine_list_view.dart';

class SearchResultsPage extends StatelessWidget {
  const SearchResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 30,),
          Align(
            alignment: 
            Alignment.center,
            child: Text(
            "Ordina",
            style: TextStyle(fontWeight: FontWeight.w900,fontSize: 60,color: Colors.black),
            textAlign: TextAlign.center,
                ),
          ),
          Semantics(label: "Inserisci il farmaco da cercare",hint: "Premi invio per cercare",
          textField: true,child: ExcludeSemantics(child: CustomSearchBar(),)),
          SizedBox(height: 40),
          Text(
            "Risultati",
            semanticsLabel: "Risultati della Ricerca di Seguito",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.black,
            ),
          ),
          Expanded(child: MedicineListView()), //TODO: Add Semantics to List view
          SizedBox(height: 20),
        ]
      )
      );
  }
}
