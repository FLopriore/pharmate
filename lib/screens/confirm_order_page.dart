import 'package:flutter/material.dart';
import 'package:pharmate/widgets/rounded_background_rectangle.dart';
import 'package:pharmate/widgets/set_number_items.dart';

class ConfirmOrderPage extends StatelessWidget {
  final String item;
  final String pharmacy;

  const ConfirmOrderPage({super.key, required this.item, required this.pharmacy});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
        body: ListView(
      children: [
        const Align(
          alignment: Alignment.center,
          child: Text(
            "Riepilogo Ordine",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 60,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 40),
        SizedBox(
          height: 300,
          child: RoundedBackgroundRectangle(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                    child: Text("Prodotto:"),
                  ),
                  ListTile(
                    title: Text(
                      item,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    trailing: const SizedBox(
                      width: 110,
                      child: SetNumberItems(),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                    child: Text("Farmacia:"),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      pharmacy,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff0888fd),
                        foregroundColor: Colors.white,
                      ),
                        onPressed: () {
                          //TODO: submit order
                        },
                        child: const Text("Conferma Ordine")
                    ),
                  )
            ],
          )),
        ),
      ],
    ));
  }
  
}
