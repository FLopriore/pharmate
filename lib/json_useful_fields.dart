/// This class contains several methods which modify responseJson coming from
/// server, converting wrong attributes into the desired ones.
class JsonUsefulFields {
  // users/me
  static Map<String, dynamic> getUserFields(json) {
    var data = {
      "cf": json["user"]["cf"],
      "fullname": json["user"]["fullname"],
      "citta": json["user"]["citta"],
      "favourite": json["user"]["favourite"],
    };
    return data;
  }

  // ordine/utente
  static List<Map<String, dynamic>> getUserOrders(List jsonList) {
    List<Map<String, dynamic>> result = [];
    for (var json in jsonList){
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
  return result;
  }
  // farmacie/mycity
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
  static List<Map<String, dynamic>> getAvailPharmaciesWithQta(List jsonList) {
    List<Map<String, dynamic>> result = [];
    for (var element in jsonList) {
      var farmacia = {
        "nome": element["farmacia"]["nome"],
        "codice_farmacia": element["farmacia"]["codice_farmacia"],
        "citta": element["farmacia"]["citta"],
      };

      var prodotto = {
        "nome": element["prodotto"]["nome"],
        "codice_aic": element["prodotto"]["aic"],
        "prezzo": element["prodotto"]["prezzo"],
      };

      var data = {
        "farmacia": farmacia,
        "prodotto": prodotto,
        "quantita": element["quantita"],
      };
      result.add(data);
    }
    return result;
  }
}
