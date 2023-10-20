import 'package:flutter/material.dart';

class MedicineListView extends StatefulWidget {
  const MedicineListView({super.key});

  @override
  State<MedicineListView> createState() => _MedicineListViewState();
}

class _MedicineListViewState extends State<MedicineListView> {
  final List<String> listMedicines = [];  // TODO: replace String with Medicine class

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: listMedicines.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(listMedicines[index]),
            trailing: Placeholder(), // TODO: add "order now" button
          );
        }
    );
  }
}
