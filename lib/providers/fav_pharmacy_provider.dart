import 'package:flutter/cupertino.dart';

class FavPharmacyProvider with ChangeNotifier {
  String favPharmacyCode = "";

  void setFavPharma(String codiceFarmacia) {
    favPharmacyCode = codiceFarmacia;
    notifyListeners();
  }
}