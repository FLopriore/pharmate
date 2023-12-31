import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pharmate/data/api.dart';
import 'package:pharmate/data/order.dart';
import 'package:pharmate/json_useful_fields.dart';

class MyOrdersDataTable extends StatefulWidget {
  const MyOrdersDataTable({super.key});

  @override
  State<MyOrdersDataTable> createState() => _MyOrdersDataTableState();
}

class _MyOrdersDataTableState extends State<MyOrdersDataTable> {
  late Future<List<Order>> myOrdersList;
  DateFormat formatter = DateFormat().add_yMMMd();
  DateFormat accessibleFormatter = DateFormat().add_yMMMMd();

  @override
  void initState() {
    super.initState();
    myOrdersList = getMyOrders();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Order>>(
      future: myOrdersList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: FittedBox(
              alignment: Alignment.topCenter,
              child: DataTable(
                  sortColumnIndex: 0,
                  sortAscending: false,
                  dataRowMinHeight: 40.0,
                  dataRowMaxHeight: 75,
                  columns: const [
                    DataColumn(
                      label: ExcludeSemantics(child:Text("Data",
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17)),),
                      numeric: true,
                    ),
                    DataColumn(
                        label: ExcludeSemantics(child:Text("Prodotto",
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17))),),
                    DataColumn(
                      label: ExcludeSemantics(child:Text("Qtà",
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17)),),
                      numeric: true,
                    ),
                    DataColumn(
                        label: ExcludeSemantics(child:Text("Stato",
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17))),),
                  ],
                  rows: List<DataRow>.generate(
                      snapshot.data!.length,
                      (int index) => DataRow(cells: <DataCell>[
                            DataCell(Text(formatter.format(DateTime.parse(snapshot.data![index].date)),style: const TextStyle(fontSize:20),
                            semanticsLabel: "Hai ordinato il ${accessibleFormatter.format(DateTime.parse(snapshot.data![index].date))}",)),
                            DataCell(ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 170),
                              child: Text(
                                snapshot.data![index].prodotto.nome,
                                overflow: TextOverflow.visible,
                                softWrap: true,
                                style: const TextStyle(fontSize:17),
                              ),
                            )),
                            DataCell(Text(snapshot.data![index].quantita.toString(),style: const TextStyle(fontSize:20),
                            semanticsLabel: "Hai ordinato ${snapshot.data![index].quantita.toString()} prodotti",
                            )),
                            DataCell(Center(
                              child: Icon(
                                Icons.circle,
                                semanticLabel: getAccessibleStatus(snapshot.data![index].status),
                                color: getStatusColor(snapshot.data![index].status),
                              ),
                            ))
                          ]))),
            ),
          );
        } else {
          return const Scaffold(
            backgroundColor: Color(0xFFF1F1EA),
            body: Center(child: Text("Non ci sono ordini")),
          );
        }
      },
    );
  }

  Color getStatusColor(Status status) {
    switch (status) {
      case Status.PENDING:
        return Colors.red;
      case Status.ACCEPTED:
        return Colors.yellow;
      case Status.DELIVERED:
        return Colors.green;
    }
  }

  String getAccessibleStatus(Status status) {
    switch (status) {
      case Status.PENDING:
        return "Ordine non ancora accettato";
      case Status.ACCEPTED:
        return "Ordine Accettato";
      case Status.DELIVERED:
        return "Hai ritirato il prodotto";
    }
  }

  // Gets all the orders done by the user.
  // After creating the 3 lists, returns the combined list with all of them.
  Future<List<Order>> getMyOrders() async {
    List<Order> myOrders = [];

    // Get pending orders
    var response = await CallApi().getData('ordine/utente?status=PENDING');
    var modResponse = JsonUsefulFields.getUserOrders(response);
    if (modResponse.isNotEmpty) {
      myOrders =
          List<Order>.from(modResponse.map((model) => Order.fromJson(model)));
    }

    // Get accepted orders
    response = await CallApi().getData('ordine/utente?status=ACCEPTED');
    modResponse = JsonUsefulFields.getUserOrders(response);
    if (modResponse.isNotEmpty) {
      myOrders = myOrders +
          List<Order>.from(modResponse.map((model) => Order.fromJson(model)));
    }

    // Get delivered orders
    response = await CallApi().getData('ordine/utente?status=DELIVERED');
    modResponse = JsonUsefulFields.getUserOrders(response);
    if (modResponse.isNotEmpty) {
      myOrders = myOrders +
          List<Order>.from(modResponse.map((model) => Order.fromJson(model)));
    }

    return myOrders;
  }
}
