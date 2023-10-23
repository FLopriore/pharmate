import 'package:flutter/material.dart';

class MedicineListView extends StatefulWidget {
  const MedicineListView({super.key});

  @override
  State<MedicineListView> createState() => _MedicineListViewState();
}

class _MedicineListViewState extends State<MedicineListView> {
  final List<String> listMedicines = ['ciao'];  // TODO: replace String with Medicine class

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
        itemCount: listMedicines.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(listMedicines[index]),
            trailing: ElevatedButton(onPressed: (){},
              style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Color(0xCAE6FFFF))), 
              child: const Row(
                    children: [Icon(Icons.shopping_cart),Text('Ordina')])
            )
          );
        }
    );
  }
}
