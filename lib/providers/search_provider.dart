import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier {
  String searchText = "";

  void setSearchText(String text) {
    searchText = text;
    notifyListeners();
  }
}