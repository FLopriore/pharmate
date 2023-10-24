import 'package:flutter/material.dart';
import 'package:pharmate/widgets/medicine_list_tile.dart';

class MedicineListView extends StatefulWidget {
  const MedicineListView({super.key});

  @override
  State<MedicineListView> createState() => _MedicineListViewState();
}

class _MedicineListViewState extends State<MedicineListView> {
  final List<String> listMedicines = [
    'Tachipirina', 'Ibuprofene', 'Paracetamolo', 'Cardioaspirin', 'Hello', 'hello', 'ciao', 'Hello', 'hello'
  ]; // TODO: replace String with Medicine class

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Material(
        color: Colors.white, // TODO (Francesco): change background color to match Figma project
        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
        child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) => const Divider(),
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: listMedicines.length,
            itemBuilder: (BuildContext context, int index) {
              return MedicineListTile(title: listMedicines[index]); // TODO: replace with ExpansionTile
            }),
      ),
    );
  }
}
