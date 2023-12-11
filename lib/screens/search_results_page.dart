import 'package:flutter/material.dart';
import 'package:pharmate/providers/search_provider.dart';
import 'package:pharmate/widgets/custom_search_bar.dart';
import 'package:pharmate/widgets/medicine_list_view.dart';
import 'package:provider/provider.dart';

class SearchResultsPage extends StatelessWidget {
  const SearchResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 30,),
          const Align(
            alignment:
            Alignment.center,
            child: Text(
            "Ordina",
            style: TextStyle(fontWeight: FontWeight.w900,fontSize: 60,color: Colors.black),
            textAlign: TextAlign.center,
                ),
          ),
          Semantics(
              label: "Inserisci il farmaco da cercare",
              hint: "Premi invio per cercare",
              textField: true,
              child: ExcludeSemantics(child: CustomSearchBar(
                text: context.watch<SearchProvider>().searchText
              )),
          ),
          const SizedBox(height: 40),
          const Text(
            "Risultati",
            semanticsLabel: "Risultati della Ricerca di Seguito",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.black,
            ),
          ),
          const Expanded(child: MedicineListView()), //TODO: Add Semantics to List view
          const SizedBox(height: 20),
        ]
      )
      );
  }
}
