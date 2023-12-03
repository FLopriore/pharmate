import 'package:flutter/material.dart';
import 'package:pharmate/data/api.dart';
import 'package:pharmate/data/order.dart';

class MyOrdersDataTable extends StatefulWidget {
  const MyOrdersDataTable({super.key});

  @override
  State<MyOrdersDataTable> createState() => _MyOrdersDataTableState();
}

class _MyOrdersDataTableState extends State<MyOrdersDataTable> {
  late Future<List<Order>> myOrdersList;

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
                          Text("ID", style: TextStyle(fontWeight: FontWeight.bold)),
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
                            DataCell(Text(snapshot.data![index].id.toString())),
                            DataCell(Text(snapshot.data![index].item)),
                            DataCell(Text(snapshot.data![index].qta.toString())),
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
      case Status.red:
        return Colors.red;
      case Status.yellow:
        return Colors.yellow;
      case Status.green:
        return Colors.green;
    }
  }

  Future<List<Order>> getMyOrders() async {
    var responseJson = await CallApi().getData('ordini');
    List<Order> myOrders =
        List<Order>.from(responseJson.map((model) => Order.fromJson(model)));
    return myOrders;
  }
}
