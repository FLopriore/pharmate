import 'package:flutter/material.dart';

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
        child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: listMedicines.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                  title: Text(listMedicines[index]),
                  trailing: ElevatedButton.icon(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Color(0xCAE6FFFF)),
                      //foregroundColor: MaterialStatePropertyAll<Color>(Color(0xff0888FD)) // TODO (?): maybe change text color
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.shopping_cart_outlined),
                    label: const Text("Ordina"),
                  ));
            }),
      ),
    );
  }
}
