import 'package:flutter/material.dart';
import 'package:pharmate/widgets/medicine_list_tile.dart';

class BuyNowListView extends StatefulWidget {
  const BuyNowListView({super.key});

  @override
  State<BuyNowListView> createState() => _BuyNowListViewState();
}

class _BuyNowListViewState extends State<BuyNowListView> {
  final List<String> favoriteMedicinesList = [
    'Tachipirina', 'Ibuprofene', 'Paracetamolo', 'Cardioaspirin', 'Hello', 'hello', 'ciao', 'Hello', 'hello'
  ]; // TODO: replace String with Medicine class

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.white, // TODO (Francesco): change background color to match Figma project
        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
        child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            scrollDirection: Axis.vertical,
            itemCount: favoriteMedicinesList.length,
            itemBuilder: (BuildContext context, int index) {
              return MedicineListTile(
                title: favoriteMedicinesList[index],
                leading: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () {
                        setState(() {
                          favoriteMedicinesList.removeAt(index); // remove medicine from favorite
                        });
                    },
                ),
              );
            }),
      ),
    );
  }
}
