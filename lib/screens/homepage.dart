import 'package:flutter/material.dart';
import 'package:pharmate/screens/search_results_page.dart';
import 'package:pharmate/widgets/buy_now_list_view.dart';
import 'package:pharmate/widgets/custom_search_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Align(
            alignment: Alignment.center,
            child: Text(
              "Cerca Farmaco",
              semanticsLabel: "Pagina per ordinare i farmaci",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 45,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Semantics(
            label: "Inserisci il farmaco da cercare",
            hint: "Premi invio per cercare",
            textField: true,
            child: const ExcludeSemantics(
              child: CustomSearchBar.withPageRoute(page: SearchResultsPage()),
            ),
          ),
          const SizedBox(height: 60),
          const Text(
            "Acquista subito",
            semanticsLabel: "Lista per gli acquisti rapidi di seguito",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.black,
            ),
          ),
          const Expanded(child: BuyNowListView()), //TODO: Add semantics directly to list tiles
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
