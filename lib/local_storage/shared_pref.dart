import 'dart:convert';

import 'package:pharmate/data/medicine.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<List<Medicine>> getFavoriteMedicines() async {
    final prefs = await _prefs;
    String favListJson = prefs.getString('favorite') ?? "";
    List<Medicine> list = List<Medicine>.from(
        jsonDecode(favListJson).map((model) => Medicine.fromJson(model)));
    return list;
  }

  void setFavoriteMedicines(List<Medicine> list) async {
    final prefs = await _prefs;
    String favJson = jsonEncode(list);
    prefs.setString('favorite', favJson);
  }
}
