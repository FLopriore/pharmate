import 'package:json_annotation/json_annotation.dart';

/// This allows the `Pharmacy` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'pharmacy.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Pharmacy {
  String nome;
  String codice_farmacia;
  String citta;

  Pharmacy(this.nome, this.codice_farmacia, this.citta);

  /// A necessary factory constructor for creating a new Pharmacy instance
  /// from a map. Pass the map to the generated `_$PharmacyFromJson()` constructor.
  /// The constructor is named after the source class, in this case, Pharmacy.
  factory Pharmacy.fromJson(Map<String, dynamic> json) => _$PharmacyFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$PharmacyToJson`.
  Map<String, dynamic> toJson() => _$PharmacyToJson(this);
}