import 'package:flutter/material.dart';
import 'package:pharmate/data/order.dart';

class MyOrdersDataTable extends StatelessWidget {
  const MyOrdersDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    List<Order> myOrders = [];

    // TODO: get MyOrders from DB
    Order order1 = Order(1, "Tachipirina 500mg", 3, Status.green);
    Order order2 = Order(2, "Xanax 25mg", 1, Status.yellow);
    Order order3 = Order(3, "Methotrexate 10000 UI", 2, Status.red);
    myOrders.add(order1);
    myOrders.add(order2);
    myOrders.add(order3);

    return DataTable(
        sortColumnIndex: 0,
        sortAscending: true,
        columns: const [
          DataColumn(
            label: Text("ID", style: TextStyle(fontWeight: FontWeight.bold)),
            numeric: true,
          ),
          DataColumn(
              label: Text("Prodotto", style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
            label: Text("Qtà", style: TextStyle(fontWeight: FontWeight.bold)),
            numeric: true,
          ),
          DataColumn(
              label: Text("Status", style: TextStyle(fontWeight: FontWeight.bold))),
        ],
        rows: List<DataRow>.generate(
            myOrders.length,
            (int index) => DataRow(cells: <DataCell>[
                  DataCell(Text(myOrders[index].id.toString())),
                  DataCell(Text(myOrders[index].item)),
                  DataCell(Text(myOrders[index].qta.toString())),
                  DataCell(Center(
                    child: Icon(
                      Icons.circle,
                      color: getStatusColor(myOrders[index].status),
                    ),
                  ))
                ])));
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
}
