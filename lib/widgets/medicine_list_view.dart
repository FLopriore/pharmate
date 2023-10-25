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
  final List<String> listPharma = [
    'Farmacia Del Cambio','Farmacia Calia','Open Pharma'
  ];//TODO: Replace with DB Pharmas


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Material(
        color: Colors.white, 
        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
        child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) => const Divider(),
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: listMedicines.length,
            itemBuilder: (BuildContext context, int index) {
              return ExpansionTile(
                title: Text(listMedicines.elementAt(index)),
                trailing: IconButton(
                  icon: Icon(Icons.grade_outlined),
                  onPressed: () {},//TODO: Add to Favourite the medicine
                  style: ButtonStyle(iconColor: MaterialStateProperty.all(Color(0xff0888FD)))),//TODO: add action when icon pressed
                children: [for ( var i in listPharma ) TextButton(child:Text(i.toString()),onPressed: () {},)], //TODO: add pharmas that have medicine, Add order to my orders
                );
            }),
      ),
    );
  }
}
