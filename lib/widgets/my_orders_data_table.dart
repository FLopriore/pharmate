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
  DateFormat formatter = DateFormat('yyyy-mm-dd');

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
                  sortAscending: true,
                  columns: const [
                    DataColumn(
                      label:
                          Text("Data", style: TextStyle(fontWeight: FontWeight.bold)),
                      numeric: true,
                    ),
                    DataColumn(
                        label: Text("Prodotto",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                      label: Text("Qtà",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      numeric: true,
                    ),
                    DataColumn(
                        label: Text("Stato",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  rows: List<DataRow>.generate(
                      snapshot.data!.length,
                      (int index) => DataRow(cells: <DataCell>[
                            DataCell(Text(formatter.format(DateTime.parse(snapshot.data![index].date)))),
                            DataCell(Text(snapshot.data![index].prodotto.nome)),
                            DataCell(Text(snapshot.data![index].quantita.toString())),
                            DataCell(Center(
                              child: Icon(
                                Icons.circle,
                                color: getStatusColor(snapshot.data![index].status),
                              ),
                            ))
                          ]))),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a blank Scaffold.
        return const Scaffold(backgroundColor: Color(0xFFF1F1EA));
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

  Future<List<Order>> getMyOrders() async {
    var responseJson = await CallApi().getData('ordini');
    // TODO: remove when server is complete
    var modresponseJson = JsonUsefulFields.getUserOrders(responseJson!);

    List<Order> myOrders =
        List<Order>.from(modresponseJson.map((model) => Order.fromJson(model)));

    return myOrders;
  }
}
