import 'package:flutter/material.dart';
import 'package:pharmate/widgets/custom_search_bar.dart';
import 'package:pharmate/widgets/medicine_list_view.dart';

class SearchResultsPage extends StatelessWidget {
  const SearchResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
      body: const Column(
        children: [
          Align(
            alignment: 
            Alignment.center,
            child: Text(
            "Ordina",
            style: TextStyle(fontWeight: FontWeight.w900,fontSize: 60,color: Colors.black),
            textAlign: TextAlign.center,
                ),
          ),
          CustomSearchBar(),
          SizedBox(height: 40),
          Text(
            "Risultati",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.black,
            ),
          ),
          Expanded(child: MedicineListView()),
          SizedBox(height: 20),
        ]
      )
      );
  }
}
