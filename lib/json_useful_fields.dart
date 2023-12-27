import 'package:pharmate/data/pharmacy.dart';

/// This class contains several methods which modify responseJson coming from
/// server, converting wrong attributes into the desired ones.
class JsonUsefulFields {
  // users/me
  static Map<String, dynamic> getUserFields(json) {
    if (json["favourite"] != null) {
      return {
        "cf": json["cf"],
        "fullname": json["fullname"],
        "citta": json["citta"],
        "favourite": json["favourite"],
      };
    }

    // Set pharmacy where you work as favorite.
    // This section is executed only if the account belongs to a pharmacy owner.
    return {
      "cf": json["cf"],
      "fullname": json["fullname"],
      "citta": json["citta"],
      "favourite": json["worksIn"],
    };
  }

  // ordine/utente
  static List<Map<String, dynamic>> getUserOrders(List? jsonList) {
    List<Map<String, dynamic>> result = [];
    if (jsonList != null) {
      for (var json in jsonList) {
        var prodotto = {
          "codice_aic": json["prodotto"]["aic"],
          "nome": json["prodotto"]["nome"],
          "prezzo": json["prodotto"]["prezzo"]
        };
        var data = {
          "uuid": json["uuid"],
          "farmacia": json["farmacia"],
          "prodotto": prodotto,
          "quantita": json["quantita"],
          "date": json["date"],
          "status": json["status"],
        };
        result.add(data);
      }
    }
    return result;
  }

  // farmacie/find
  static List<Map<String, dynamic>> getMyCityPharmacies(List jsonList) {
    List<Map<String, dynamic>> result = [];
    for (var element in jsonList) {
      var data = {
        "nome": element["nome"],
        "codice_farmacia": element["codice_farmacia"],
        "citta": "",
      };
      result.add(data);
    }
    return result;
  }

  // prodotti/avail/{aic}
  static List<Map<String, dynamic>> getAvailPharmaciesWithQta(json) {
    List<Map<String, dynamic>> result = [];
    if (json != null) {
      // favourite pharmacy
      if (json["preferita"] != null) {
        var preferita = {
          "farmacia": json["preferita"]["farmacia"],
          "quantita": json["preferita"]["quantita"],
        };
        result.add(preferita);
      }

      // other pharmacies
      List others = json["disponibilita"];
      if (others.isNotEmpty) {
        for (var element in others) {
          var data = {
            "farmacia": element["farmacia"],
            "quantita": element["quantita"],
          };
          result.add(data);
        }
      }
    }
    return result;
  }

  // prodotti/avail/{aic} (only with favorite pharmacy)
  static Map<String, dynamic> getAvailMedicineFavPharma(json) {
    Map<String, dynamic> data;
    if (json["preferita"] != null) {
      data = {
        "farmacia": json["preferita"]["farmacia"],
        "quantita": json["preferita"]["quantita"],
      };
    } else {
      data = {
        "farmacia": Pharmacy("", "", "").toJson(),
        "quantita": 0,
      };
    }
    return data;
  }
}
