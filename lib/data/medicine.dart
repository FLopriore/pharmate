import 'package:json_annotation/json_annotation.dart';

/// This allows the `Medicine` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'medicine.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Medicine {
  String codice_aic;
  String nome;
  num prezzo;

  Medicine(this.codice_aic, this.nome, this.prezzo); // quantity of items

  /// A necessary factory constructor for creating a new Medicine instance
  /// from a map. Pass the map to the generated `_$MedicineFromJson()` constructor.
  /// The constructor is named after the source class, in this case, Medicine.
  factory Medicine.fromJson(Map<String, dynamic> json) => _$MedicineFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$MedicineToJson`.
  Map<String, dynamic> toJson() => _$MedicineToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    return other is Medicine && other.codice_aic == codice_aic;
  }

  @override
  int get hashCode => codice_aic.hashCode;
}
