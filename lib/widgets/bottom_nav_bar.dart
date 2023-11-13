import 'package:flutter/material.dart';
import 'package:pharmate/screens/homepage.dart';
import 'package:pharmate/screens/my_orders_page.dart';

/*
* This widget is a navigation bar shown on the bottom of the screen.
* You can select one of these pages:
*   - Home (default)
*   - Reminder
*   - My orders
* */
class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentPageIndex = 1; // default page is home

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.access_time_filled_outlined),
            icon: Icon(Icons.access_time_outlined),
            label: 'Promemoria',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.local_shipping),
            icon: Icon(Icons.local_shipping_outlined),
            label: 'I miei ordini',
          ),
        ],
      ),
      body: SafeArea(
        child: <Widget>[
          Placeholder(), // TODO: add "reminder" widget
          const HomePage(),
          const MyOrdersPage(),
        ][currentPageIndex],
      ),
    );
  }
}
