import 'package:flutter/material.dart';
import 'package:pharmate/data/api.dart';
import 'package:pharmate/widgets/rounded_background_rectangle.dart';
import 'package:pharmate/widgets/set_number_items.dart';

class ConfirmOrderPage extends StatelessWidget {
  final String item;
  final String pharmacy;
  static int _numItems = 1;

  const ConfirmOrderPage({super.key, required this.item, required this.pharmacy});

  // Used to get value from child widget.
  // I didn't use any state management packages in order not to over-engineer.
  callBack(int num) {
    _numItems = num;
  }

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
                  fontSize: 50,
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
                    padding:
                        EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
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
                    trailing: SizedBox(
                      width: 120,
                      child: SetNumberItems(callBack: callBack),
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                    child: Text("Farmacia:"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
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
                        onPressed: () async {
                          var data = {
                            'item': item,
                            'pharmacy': pharmacy,
                            'qta': _numItems,
                            'status': 'red',
                          };
                          await CallApi()
                              .postData(data, 'ordini')
                              .then((responseJson) {
                            if (responseJson != null) {
                              showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        backgroundColor: Colors.white,
                                        title: const Text('Esito ordine'),
                                        content:
                                            const Text('Ordine confermato'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'OK'),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ));
                            }
                          });
                        },
                        child: const Text("Conferma Ordine")),
                  )
                ],
              )),
            ),
          ],
        ));
  }
}
